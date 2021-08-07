defmodule Zoop.CreditCard do
  @moduledoc """
  Criando o struct para uso nos modulos

      iex> card = %Zoop.CreditCard{
        on_behalf_of: "",
        description: "",
        source: %Zoop.CreditCard.Source{
          card: %Zoop.CreditCard.Source.Card{}
        }
      }
  """

  @derive Jason.Encoder
  @enforce_keys [:on_behalf_of, :description]

  alias Zoop.CreditCard.Source

  defstruct on_behalf_of: "",
            description: "",
            statement_descriptor: "",
            payment_type: "credit",
            capture: false,
            reference_id: "",
            source: %Source{},
            installment_plan: %{number_installments: 0}
end
