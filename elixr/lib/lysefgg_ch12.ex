defmodule Elixr.Lysefgg.Linkmon do
  @doc """
  Examples:

  # This kills the shell(iex for elixir) process (?)
  iex> spawn(fn -> Linkmon.myproc/0 end)
  #PID<0.401.0>
  iex> self()
  #PID<0.391.0>
  iex> Process.link(spawn(fn -> Linkmon.myproc/0 end))
  true
  # after 3 seconds
  iex> ** (EXIT from #PID<0.391.0> ) "reason"
  Interactive Elixir (1.4.0) - press Ctrl+C to exit (type h() ENTER for help)
  ** (exit) "reason"
      (elixir) lib/lysefgg_ch12.ex:4: Elixr.Lysefgg.Linkmon.myproc/0

  # This doesn't
  iex> spawn(Linkmon.myproc/0)
  # after 3 seconds
  ** (exit) "reason"
      (elixir) lib/lysefgg_ch12.ex:4: Elixr.Lysefgg.Linkmon.myproc/0
  iex> Process.link(spawn(Linkmon.myproc/0))
  # after 3 seconds
  ** (exit) "reason"
      (elixir) lib/lysefgg_ch12.ex:4: Elixr.Lysefgg.Linkmon.myproc/0

  # Anyway, the error here won't be caught by try..catch,
  """
  def myproc do
    :timer.sleep(3000)
    exit("reason")
  end

  @doc """
  # Process.link links current process
  iex> spawn(Elixr.Lysefgg.Linkmon, :chain, [3]) |> Process.link
  [shell] == 3
  true 
  [shell] == 2
  [shell] == 1
  [shell] == [3]
  """
  def chain(0) do
    IO.puts "[shell] == [3]"
    receive do
    _ -> :ok
    after 2000 ->
      exit("chain dies here, killing also the shell process which is also the calling process")
    end
  end

  def chain(n) do
    IO.puts "[shell] == #{n}"
    spawn(fn -> chain(n - 1) end) |> Process.link
    receive do
    _ -> :ok
    end
  end
end
