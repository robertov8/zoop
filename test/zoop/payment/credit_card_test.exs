defmodule Zoop.Payment.CreditCardTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Zoop.{Client, CreditCard, Payment}

  @base_url Client.get_base_url()

  @credit_card %CreditCard{
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

  describe "pay_credit_card/1" do
    test "when sending a card, return payment data" do
      body = %{
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

      mock(fn %{method: :post, url: "#{@base_url}/transactions"} ->
        %Tesla.Env{status: 201, body: body}
      end)

      response = Payment.CreditCard.pay_credit_card(@credit_card)

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
  end

  describe "pay_credit_card/2" do
    test "when sending a card and reference code, return payment data" do
      reference_id = "123"

      body = %{
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

      mock(fn %{method: :post, url: "#{@base_url}/transactions"} ->
        %Tesla.Env{status: 201, body: body}
      end)

      response = Payment.CreditCard.pay_credit_card(@credit_card, reference_id)

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
