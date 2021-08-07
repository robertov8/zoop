defmodule Zoop.MarketPlace.BuyersTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Zoop.{Client, MarketPlace}
  alias MarketPlace.Buyers

  @base_url Client.get_base_url()

  describe "search_buyer/1" do
    @taxpayer_id "16778481897"
    @url "#{@base_url}/buyers/search"

    test "when searching for cpf, return a buyer" do
      mock(fn %{method: :get, url: @url, query: [taxpayer_id: @taxpayer_id]} ->
        %Tesla.Env{
          status: 200,
          body: %{
            "id" => "ee59530a7c9f4741ab108090e5f2ac05",
            "taxpayer_id" => "16778481897"
          }
        }
      end)

      response = Buyers.search_buyer(@taxpayer_id)

      assert {:ok, %{"id" => _id, "taxpayer_id" => @taxpayer_id}} = response
    end

    test "when searching for invalid cpf, return an error" do
      mock(fn %{method: :get, url: @url, query: [taxpayer_id: "12345678"]} ->
        %Tesla.Env{
          status: 404,
          body: %{
            "error" => %{
              "category" => "resource_not_found",
              "message" =>
                "Sorry, the taxpayer_id you are trying to use does not exist or has been deleted.",
              "status" => "Not Found",
              "status_code" => 404,
              "type" => "invalid_request_error"
            }
          }
        }
      end)

      response = Buyers.search_buyer("12345678")

      assert {:error, _error} = response
    end
  end
end
