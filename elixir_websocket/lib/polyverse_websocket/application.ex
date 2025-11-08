defmodule PolyverseWebsocket.Application do
  @moduledoc """
  🟣 Elixir WebSocket Service
  Real-time WebSocket server for Polyverse
  """
  
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PolyverseWebsocket.Router, options: [port: 8085]}
    ]

    opts = [strategy: :one_for_one, name: PolyverseWebsocket.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

