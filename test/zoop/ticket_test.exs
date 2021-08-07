defmodule Zoop.TicketTest do
  use ExUnit.Case

  alias Zoop.Ticket

  test "when encode, returns the quantity multiplied by 100" do
    ticket =
      %Ticket{on_behalf_of: "", amount: 189.99, description: ""}
      |> Jason.encode!()
      |> Jason.decode!()

    assert %{"amount" => 18999} = ticket
  end
end
