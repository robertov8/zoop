defmodule Zoop.Payment.Ticket do
  @moduledoc """
  Essa modulo é responsavel por realizar o pagamento
  utilizando o cartão de credito, preparando e hidratando
  o mesmo com os dados estaticos.
  """

  alias Zoop.{Client, Ticket}

  def generate_ticket(%Ticket{} = ticket, user_id, reference_id \\ nil) do
    transaction =
      %{ticket | customer: user_id, reference_id: reference_id}
      |> process_transactions()

    case transaction do
      {:ok, body} ->
        transation_body = handle_generated_transation(body)

        Client.get("boletos/" <> transation_body["ticket_id"])
        |> handle_response()
        |> handle_generated_ticket(user_id, transation_body)

      {:error, body} ->
        {:error, body}

      _ ->
        {:error}
    end
  end

  defp process_transactions(%Ticket{} = ticket) do
    Client.post("transactions", ticket) |> handle_response()
  end

  defp handle_generated_transation(body) do
    %{
      "id" => body["id"],
      "ticket_id" => body["payment_method"]["id"],
      "status" => body["status"]
    }
  end

  defp handle_generated_ticket({:ok, body}, user_id, transation_body) do
    %{
      "payment" => %{
        "id" => transation_body["id"],
        "ticket_id" => transation_body["ticket_id"],
        "url" => body["url"],
        "barcode" => body["barcode"],
        "status" => transation_body["status"]
      },
      "user_id" => user_id
    }
  end

  defp handle_response({:ok, %Tesla.Env{body: body, status: 200}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{body: body, status: 201}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{body: body}}), do: {:error, body}
  defp handle_response(_), do: {:error, %{}}
end
