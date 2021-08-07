defmodule Zoop.CreditCard.Source.Card do
  @moduledoc """
  Criando o struct para uso nos modulos

      iex> card = %Zoop.CreditCard.Source.Card{}
  """

  @derive Jason.Encoder

  defstruct card_number: "",
            holder_name: "",
            expiration_month: "",
            expiration_year: "",
            security_code: ""
end
