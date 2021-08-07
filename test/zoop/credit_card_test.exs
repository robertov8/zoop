defmodule Zoop.CreditCardTest do
  use ExUnit.Case

  alias Zoop.CreditCard

  test "when encode, returns the quantity multiplied by 100" do
    credit_card =
      %CreditCard{
        on_behalf_of: "001960906eae4ac4a14128ccba603c36",
        description: "Teste",
        source: %CreditCard.Source{
          amount: 89.88,
          card: %CreditCard.Source.Card{
            card_number: "5201561050024014",
            holder_name: "João Silva",
            expiration_month: "03",
            expiration_year: "2022",
            security_code: "123"
          }
        }
      }
      |> Jason.encode!()
      |> Jason.decode!()

    assert %{"source" => %{"amount" => 8988}} = credit_card
  end
end
