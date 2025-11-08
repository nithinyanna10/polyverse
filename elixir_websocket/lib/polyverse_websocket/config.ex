defmodule PolyverseWebsocket.Config do
  @moduledoc "Configuration for WebSocket service"
  
  def port, do: Application.get_env(:polyverse_websocket, :port, 8085)
  def max_connections, do: Application.get_env(:polyverse_websocket, :max_connections, 1000)
end

