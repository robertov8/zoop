defmodule Zoop.Payment.CreditCardTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Zoop.{Client, CreditCard, Payment}

  @base_url Client.get_base_url()

  describe "pay_credit_card/1" do
    test "when sending a card, return payment data" do
      mock(fn %{method: :post, url: "#{@base_url}/transactions"} ->
        %Tesla.Env{
          status: 201,
          body: %{
            "resource" => "transaction",
            "id" => "eb2f6e40c50542f68a23ebf5697a32b1",
            "status" => "pre_authorized",
            "source" => %{
              "amount" => 89.88,
              "card" => %{
                "holder_name" => "João Silva"
              }
            }
          }
        }
      end)

      response =
        Payment.CreditCard.pay_credit_card(%CreditCard{
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
        })

      assert {:ok,
              %{
                "id" => _id,
                "status" => "pre_authorized",
                "source" => %{
                  "amount" => 89.88,
                  "card" => %{
                    "holder_name" => "João Silva"
                  }
                }
              }} = response
    end

    test "when sending an invalid card, return an error" do
      mock(fn %{method: :post, url: "#{@base_url}/transactions"} ->
        %Tesla.Env{
          status: 402,
          body: %{
            "error" => %{
              "category" => "invalid_card_number",
              "message" => "The card number is not a valid credit card number.",
              "message_display" => "CARTAO INVALIDO",
              "status" => "Request Failed",
              "status_code" => 402,
              "type" => "card_error"
            }
          }
        }
      end)

      response =
        Payment.CreditCard.pay_credit_card(%CreditCard{
          on_behalf_of: "001960906eae4ac4a14128ccba603c36",
          description: "Teste",
          source: %CreditCard.Source{
            amount: 89.88,
            card: %CreditCard.Source.Card{
              card_number: "12345679",
              holder_name: "João Silva",
              expiration_month: "03",
              expiration_year: "2022",
              security_code: "123"
            }
          }
        })
    end
  end

  describe "pay_credit_card/2" do
    test "when sending a card and reference code, return payment data" do
      reference_id = "123"

      mock(fn %{method: :post, url: "#{@base_url}/transactions"} ->
        %Tesla.Env{
          status: 201,
          body: %{
            "resource" => "transaction",
            "id" => "eb2f6e40c50542f68a23ebf5697a32b1",
            "status" => "pre_authorized",
            "reference_id" => reference_id,
            "source" => %{
              "amount" => 89.88,
              "card" => %{
                "holder_name" => "João Silva"
              }
            }
          }
        }
      end)

      response =
        Payment.CreditCard.pay_credit_card(
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
          },
          reference_id
        )

      assert {:ok,
              %{
                "id" => _id,
                "status" => "pre_authorized",
                "reference_id" => "123",
                "source" => %{
                  "amount" => 89.88,
                  "card" => %{
                    "holder_name" => "João Silva"
                  }
                }
              }} = response
    end
  end
end
