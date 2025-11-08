defmodule PolyverseWebsocket.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/health" do
    send_resp(conn, 200, Jason.encode!(%{
      service: "Elixir WebSocket",
      status: "operational",
      version: "0.1.0"
    }))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end

