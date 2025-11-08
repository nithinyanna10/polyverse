defmodule PolyverseWebsocket.WebSocketHandler do
  @behaviour :cowboy_websocket

  def init(req, opts) do
    {:cowboy_websocket, req, opts}
  end

  def websocket_init(state) do
    {:ok, state}
  end

  def websocket_handle({:text, message}, state) do
    response = Jason.encode!(%{
      echo: message,
      timestamp: DateTime.utc_now() |> DateTime.to_iso8601()
    })
    {:reply, {:text, response}, state}
  end

  def websocket_handle(_frame, state) do
    {:ok, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end
end

