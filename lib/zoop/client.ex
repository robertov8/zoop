defmodule Zoop.Client do
  @moduledoc false

  use Tesla

  alias Zoop.Config

  @config %Config{}

  plug(Tesla.Middleware.BaseUrl, get_base_url())
  plug(Tesla.Middleware.Headers, [{"Authorization", "Basic " <> Base.encode64(@config.token)}])
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Logger, debug: enable_logger())

  def get_base_url do
    "https://api.zoop.ws/v1/marketplaces/#{@config.marketplace_id}"
  end

  def enable_logger() do
    if(System.get_env("DEBUG") == "true") do
      true
    else
      false
    end
  end
end
