defmodule Lye.DCA.Sup do
  def start(module, args) do
    spawn(__MODULE__, :init, [{module, args}])
  end
  
  def start_link(module, args) do
    spawn_link(__MODULE__, :init, [{module, args}])
  end
  
  def init({module, args}) do
    Process.flag(:trap_exit, true)
    loop({module, :start_link, args})
  end
  
  def loop({module, func, args}) do
    pid = apply(module, func, args)
    receive do
      {:EXIT, _from, :shutdown} ->
        exit(:shutdown)
      {:EXIT, pid, reason} ->
        IO.puts "Process exited: #{reason}"
        loop({module, func, args})
    end
  end
end
