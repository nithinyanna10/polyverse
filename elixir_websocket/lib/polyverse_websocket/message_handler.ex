defmodule PolyverseWebsocket.MessageHandler do
  def handle_message(message) do
    case Jason.decode(message) do
      {:ok, data} -> process_data(data)
      {:error, _} -> {:error, "Invalid JSON"}
    end
  end
  
  defp process_data(data) do
    {:ok, %{echo: data, timestamp: DateTime.utc_now()}}
  end
end

