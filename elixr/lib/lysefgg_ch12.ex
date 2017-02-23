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
  Detecting if relied process has died. To kill this process, use 
  Process.exit(critic, :message), not exit/1. Using exit/1 exits the calling 
  process (in this case, the shell).

  Sample is in Learn You some Erlang book

  Problem 1: Simulate a :snow_storm, the process is not restarted automatically 
  (Ideally, it should be!)

  iex> alias Elixr.Lysefgg.Linkmon
  iex> critic = Linkmon.start_critic()
  iex> Linkmon.judge(critic, "Eraserheads", "Cutterpillow")
  They are terrible!
  iex> Process.exit(critic, :snow_storm)
  (exit) #PID<0.224.0>
  iex> Linkmon.judge(critic, "Eraserhead", "Cutterpillow")
  :timeout

  Solution 1: Add a basic "supervisor", only job is to restart critic when it crashes

  iex> alias Elixr.Lysefgg.Linkmon
  iex> critic = Linkmon.start_critic()
  iex> Linkmon.judge(critic, "Eraserheads", "Cutterpillow")
  # problem 2 starts here
  :timeout

  Problem 2: We now have a process that just monitors and linked to ```critic()``` but
  the ```restarter``` process doesn't know the PID of ```critic```. 

  iex> alias Elixr.Lysefgg.Linkmon
  iex> critic = Linkmon.start_critic2()
  iex> Linkmon.judge(critic, "Eraserheads", "Cutterpillow")
  # problem 3 starts here
  :timeout

  Solution 3: Do a ```Process.register``` to register the process linked to the restarter
  

  Problem 3: Still receiving timeouts because ```restarter``` doesn't know how to send to
  critic the message it received
  """
  def start_critic do
    spawn(__MODULE__, :critic, [])
  end

  def judge(pid, band, album) do
    # always ensure the message here matches the pattern in critic, will always go timeout
    # if not
    send pid, {self(), {band, album}}
    receive do
      {_pid, criticism} -> criticism
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

  # starting a very basic ```supervisor``` process, restarts ```critic()```
  def start_critic2 do
    spawn(__MODULE__, :restarter, [])
  end

  @doc """

  """
  def restarter do
    Process.flag(:trap_exit, true)
    pid = spawn_link(__MODULE__, :critic, []) # link ```restarter``` and ```critic```
    Process.register(pid, :critic)            # then register process as :critic
    receive do
      {'EXIT', pid, :normal} -> :ok          # not a crash
      {'EXIT', pid, :shutdown} -> :ok        # manual termination not a crash
      {'EXIT', pid, _} -> restarter()
    end
  end

  def judge2(band, album) do
    send :critic, {self(), {band, album}} 

    # call the usual way, as in invoking directly, passing arguments
    # Assume that the pid of :critic is the same after the first two lines of the function

    # this flow might happen:
    # - send critic, message
    # - critic receives
    # - critic responds
    # - critic receives
    # - Process.whereis(:critic) fails
    # - code crashes

    # this also might happen:
    # - send critic, message
    # - critic receives
    # - critic responds
    # - critic receives
    # - Process.whereis(:critic) gets wrong pid
    # - message never matches

    # the :critic atom can be seen by multiple processes, this is called shared state
    # where other processes can access and modify the value of :critic at virtually
    # the same time which might result in inconsistent info, also known as race condition.
    # Race conditions are dangerous if you have to depend on the order of events.
    pid = Process.whereis(:critic)

    receive do # called when receiving messages from other processes
      {pid, criticism} -> criticism
    after 2000 ->
      :timeout
    end
  end

  @doc """
  Instead of getting the name of the process, make a reference of the current process
  and pass it along with the message to the intended receiver. 
  """
  def judge3(band, album) do
    ref = make_ref()
    send :critic, {self(), ref, {band, album}} # :critic is in ```registered/3```
    receive do 
      {pid, criticism} -> criticism
    after 2000 ->
      :timeout
    end
  end

  def critic3() do
    receive do
      {from, ref, {"Rage Against The Turing Machine", "Unit Testify"}} ->
        send from, {ref, "They are great!"}
      {from, ref, {"System of a Downtime", "Memoize"}} ->
        send from, {ref, "They're not Johnny Crash but they're good."}
      {from, ref, {"Johnny Crash", "The Token of Ring and Fire"}} ->
        send from, {ref, "Simply incredible"}
      {from, ref, {_band, _album}} ->
        send from, {ref, "They are terrible!"}
    end
    # do a TC
    critic3()
  end

  def start_critic3 do
    spawn(__MODULE__, :restarter3, [])
  end

  def restarter3 do
    Process.flag(:trap_exit, true)
    pid = spawn_link(__MODULE__, :critic3, []) # link ```restarter``` and ```critic```
    Process.register(pid, :critic)            # then register process as :critic
    receive do
      {'EXIT', pid, :normal} -> :ok          # not a crash
      {'EXIT', pid, :shutdown} -> :ok        # manual termination not a crash
      {'EXIT', pid, _} -> restarter()
    end
  end
end
