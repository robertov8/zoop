defmodule Zoop.MarketPlace.Buyers do
  @moduledoc """
  Essa classe é resposavel por lidar com os usuarios
  dentro do marketplace ao nivel do marketplace zoop.
  """

  alias Zoop.{Buyers, Client}

  @doc """
  Busca os usuario por CPF/CNPJ
  """
  def search_buyer(taxpayer_id) do
    Client.get("buyers/search", query: [taxpayer_id: taxpayer_id])
    |> handle_response()
  end

  @doc """
  Pega os dados do usuario associado
  ao id passado como parametro.
  """
  def get_buyer(user_id) do
    Client.get("buyers/#{user_id}") |> handle_response()
  end

  @doc """
  Cria o usuario dentro do markeplace ('não é associado ao vendedor')
  """
  def create_buyer(%Buyers{} = buyers) do
    case Client.post("buyers", buyers) do
      {:ok, %Tesla.Env{body: body}} when is_binary(body) ->
        {:ok, Jason.decode(body)}

      {:ok, %Tesla.Env{body: body}} ->
        {:ok, body}

      _ ->
        {:error, %{}}
    end
  end

  @doc """
  Lista todos os usuarios do marketplace
  ('não realiza associação com o vendedor')
  """
  def get_all_buyers do
    Client.get("buyers") |> handle_response()
  end

  @doc """
  Atualiza os dados do comprador
  """
  def update_buyer(user_id, %Buyers{} = buyers) do
    Client.put("buyers/#{user_id}", buyers) |> handle_response()
  end

  @doc """
  Deleta um usuario do marketplace utilizando como parametro
  """
  def delete_buyer(user_id) do
    Client.delete("buyers/#{user_id}") |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{body: body, status: 200}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{body: body}}), do: {:error, body}
  defp handle_response(_), do: {:error, %{}}
end
