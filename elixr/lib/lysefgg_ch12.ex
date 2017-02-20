defmodule Elixr.Lysefgg.Linkmon do
  @doc """
  Properly trapping process errors using Process.flag(:trap_exit, true). Manually doing
  spawn and links 
  
  Examples:

  iex> Process.flag(:trap_exit, true)
  true

  # prints out ```true```
  iex> spawn(Elixr.Lysefgg.Linkmon, :chain, [3]) |> Process.link
  [shell] == 3
  true
  [shell] == 2
  [shell] == 1
  [shell] == [3]

  # or, prints out a PID
  iex> spawn_link(Elixr.Lysefgg.Linkmon, :chain, [3])
  [shell] == 3
  #PID<0.49.0>
  [shell] == 2
  [shell] == 1
  [shell] == [3]

  # do a flush() to see caught errors

  Examples:

  # This kills the shell(iex for elixir) process since it is the calling process
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

  iex> spawn(Linkmon.myproc/0)
  # after 3 seconds
  ** (exit) "reason"
      (elixir) lib/lysefgg_ch12.ex:4: Elixr.Lysefgg.Linkmon.myproc/0
  iex> Process.link(spawn(Linkmon.myproc/0))
  # after 3 seconds
  ** (exit) "reason"
      (elixir) lib/lysefgg_ch12.ex:4: Elixr.Lysefgg.Linkmon.myproc/0

  # The error here won't be caught by try..catch.
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

  @doc """
  Detecting if relied process has died
  """

  # to kill this process, use Process.exit(critic, :message), not exit/1
  # using exit/1 exits the calling process (shell)
  # Sample is in Learn You some Erlang book

  # simulate a :snow_storm, the process is not restarted automatically (Ideally, it should be!)

  # iex> alias Elixr.Lysefgg.Linkmon
  # iex> critic = Linkmon.start_critic()
  # iex> Linkmon.judge(critic, "Eraserhead", "Cutterpillow")
  # They are terrible!
  # iex> Process.exit(critic, :snow_storm)
  # (exit) #PID<0.224.0>
  # iex> Linkmon.judge(critic, "Eraserhead", "Cutterpillow")
  # :timeout

  def start_critic do
    spawn(__MODULE__, :critic, [])
  end

  def judge(pid, band, album) do
    # always ensure the message here matches the pattern in critic, will always go timeout
    # if not
    send pid, {self(), {band, album}}
    receive do
      {pid, criticism} -> criticism
    after 2000 ->
      :timeout
    end
  end

  def critic do
    receive do
      {from, {"Rage Against The Turing Machine", "Unit Testify"}} ->
        send from, {self(), "They are great!"}
      {from, {"System of a Downtime", "Memoize"}} ->
        send from, {self(), "They're not Johnny Crash but they're good."}
      {from, {"Johnny Crash", "The Token of Ring and Fire"}} ->
        send from, {self(), "Simply incredible"}
      {from, {_band, _album}} ->
        send from, {self(), "They are terrible!"}
    end
    critic()
  end

  # starting a very basic ```supervisor``` process
  def start_critic2 do
    spawn(__MODULE__, :restarter, [])
  end

  def restarter do
    Process.flag(:trap_exit, true)
    pid = spawn_link(__MODULE__, :critic, [])
    receive do
      {'EXIT', pid, :normal} -> :ok   # not a crash
      {'EXIT', pid, :shutdown} -> :ok # manual termination not a crash
      {'EXIT', pid, _} -> :ok
    end
  end
end
