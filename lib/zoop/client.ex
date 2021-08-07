defmodule Zoop.Client do
  @moduledoc false

  use Tesla

  alias Zoop.Config

  @config %Config{}

  plug(Tesla.Middleware.BaseUrl, get_base_url())
  plug(Tesla.Middleware.Headers, [{"Authorization", "Basic " <> Base.encode64(@config.token)}])
  plug(Tesla.Middleware.JSON)
  # plug(Tesla.Middleware.Logger)

  def get_base_url do
    "https://api.zoop.ws/v1/marketplaces/#{@config.marketplace_id}"
  end
end
