defmodule Lye.Dolphin do
  @moduledoc """
  single run only, you have to do a spawn again to process new actions
  Examples

  # current process is waiting for message
  # which will arrive when the ```receive``` expression is hit
  iex> dolphin = spawn(Lye.Dolphin, :dolphin!, [])
  #PID<0.259>

  # receive pattern matches here
  iex> send dolphin, :do_a_flip

  # process outputs the message
  How about no?
  :do_a_flip
  iex> send dolphin, :do_a_flip
  :do_a_flip

  # process terminates, you need to spawn a process again
  iex> Process.alive? dolphin
  false
  """
  def dolphin1 do
    receive do
      :do_a_flip -> :io.format("How about no?~n")
      :fish -> :io.format("So long and thanks for all the fish!~n")
      _ -> :io.format("Heh, we're smarter than you humans~n")
    end
  end

  #
  # we still need to spawn a new process everytime a process is finished
  def dolphin2 do
    receive do
      {sender, :do_a_flip} ->
        send sender, "How about no?"
      {sender, :fish} ->
        send sender, "So long and thanks for all the fish!"
      _ -> :io.format("Heh, we're smarter than you humans~n")
    end
  end

  # to avoid spawning new process everytime a message is sent to the mailbox
  # use recursion
  # iex> dolphin = spawn(Lye.Dolphin, :dolphin!, [])
  # #PID<0.259>

  # # receive pattern matches here
  # iex> send dolphin, :do_a_flip

  # # process outputs the message
  # How about no?
  # :do_a_flip
  # iex> send dolphin, :do_a_flip
  # :do_a_flip

  # # process terminates, you need to spawn a process again
  # iex> Process.alive? dolphin
  # false
  def dolphin3 do
    receive do
      {sender, :do_a_flip} ->
        send sender, "How about no?"
        dolphin3()
      {sender, :fish} ->
        send sender, "So long and thanks for all the fish!"
      _ ->
        :io.format("Heh, we're smarter than you humans~n")
        dolphin3()
    end
  end
end
