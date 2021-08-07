defmodule Zoop.Buyers do
  @moduledoc """
  Criando o struct para uso nos modulos

      iex> buyer = %Zoop.Buyers{}
  """

  @derive Jason.Encoder

  defstruct first_name: "",
            last_name: nil,
            email: "",
            phone_number: nil,
            taxpayer_id: nil,
            address: %{
              line1: nil,
              line2: nil,
              line3: nil,
              neighborhood: "",
              city: nil,
              state: "RJ",
              postal_code: "",
              country_code: "BR"
            }
end
