defmodule PolyverseWebsocket.ConnectionManager do
  use GenServer
  
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end
  
  def add_connection(pid) do
    GenServer.cast(__MODULE__, {:add, pid})
  end
  
  def remove_connection(pid) do
    GenServer.cast(__MODULE__, {:remove, pid})
  end
  
  def handle_cast({:add, pid}, state) do
    {:noreply, Map.put(state, pid, true)}
  end
  
  def handle_cast({:remove, pid}, state) do
    {:noreply, Map.delete(state, pid)}
  end
end

