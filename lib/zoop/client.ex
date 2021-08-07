defmodule Zoop.Client do
  @moduledoc false

  use Tesla

  alias Zoop.Config

  @config %Config{}

  plug(Tesla.Middleware.BaseUrl, "https://api.zoop.ws/v1/marketplaces/#{@config.marketplace_id}")
  plug(Tesla.Middleware.Headers, [{"Authorization", "Basic " <> Base.encode64(@config.token)}])
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Logger)
end
