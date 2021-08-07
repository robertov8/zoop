defmodule Zoop.Payment.CreditCard do
  @moduledoc """
  Essa modulo é responsavel por realizar o pagamento
  utilizando o cartão de credito, preparando e hidratando
  o mesmo com os dados estaticos.
  """

  alias Zoop.{Client, CreditCard}

  @doc """
  Gera o pagamento com cartão de credito,
  realizando com simplicidade a operação.
  """
  def pay_credit_card(%CreditCard{} = credit_card, reference_id \\ nil) do
    Client.post("transactions", %{credit_card | reference_id: reference_id})
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{body: body, status: 200}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{body: body, status: 201}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{body: body}}), do: {:error, body}
  defp handle_response(_), do: {:error, %{}}
end
