defmodule Zoop.Config do
  @moduledoc false

  defstruct marketplace_id: Application.get_env(:zoop, :marketplace_id),
            token: Application.get_env(:zoop, :token)
end
