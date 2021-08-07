defmodule Zoop.CreditCard.Source do
  @moduledoc """
  Criando o struct para uso nos modulos

      iex> source = %Zoop.CreditCard.Source{}
  """

  alias Zoop.CreditCard.Source.Card

  defstruct usage: "single_use",
            amount: 0,
            currency: "BRL",
            type: "card",
            card: %Card{}

  defimpl Jason.Encoder, for: Zoop.CreditCard.Source do
    def encode(value, opts) do
      value
      |> Map.put(:amount, trunc(value.amount * 100))
      |> Jason.Encode.map(opts)
    end
  end
end
