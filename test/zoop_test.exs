defmodule ZoopTest do
  use ExUnit.Case
  doctest Zoop

  test "greets the world" do
    assert Zoop.hello() == :world
  end
end
