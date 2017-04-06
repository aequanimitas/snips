defmodule Lye.ServerProcess do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init
      loop(callback_module, initial_state)
    end)
  end

  def call(server_pid, request) do
    send server_pid, {:call, request, self()}
    receive do
      {:response, response} -> response
    end
  end

  def cast(server_pid, request) do
    send server_pid, {:cast, request, self()}
  end

  def loop(callback_module, current_state) do
    receive do
      {:cast, request, _caller} ->
        new_state = callback_module.handle_cast(request, current_state)
        loop(callback_module, new_state)
      {:call, request, caller} ->
        response = callback_module.handle_call(request, current_state)
        send caller, {:response, response}
        loop(callback_module, current_state)
    end
  end
end
