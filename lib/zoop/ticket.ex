defmodule Zoop.Ticket do
  @moduledoc """
  Criando o struct para uso nos modulos

      iex> ticket = %Zoop.Ticket{on_behalf_of: "", amount: 0, description: ""}
  """
  @enforce_keys [:on_behalf_of, :amount, :description]

  defstruct on_behalf_of: "",
            customer: "",
            amount: 0,
            currency: "BRL",
            description: "",
            reference_id: "",
            payment_type: "boleto",
            logo: "",
            payment_method: %{
              expiration_date: "",
              payment_limit_date: "",
              body_instructions: ""
            }

  defimpl Jason.Encoder, for: Zoop.Ticket do
    def encode(value, opts) do
      value
      |> Map.put(:amount, trunc(value.amount * 100))
      |> Jason.Encode.map(opts)
    end
  end
end
