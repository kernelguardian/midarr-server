defmodule MediaServerWeb.Webhooks.SeriesController do
  use MediaServerWeb, :controller

  def create(conn, %{"eventType" => "Download"}) do
    MediaServer.SeriesIndex.reset()

    conn
    |> send_resp(201, "Ok")
  end

  def create(conn, _payload) do
    conn
    |> send_resp(200, "Ok")
  end
end
