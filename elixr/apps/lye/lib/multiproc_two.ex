
defmodule Elixr.Lysefgg.MultiprocTwo do
  def blah do
    receive do
      # when you do a send() to self(), this triggers too
      {_, message} -> IO.puts "Multiproc2: #{message}"
       _ -> IO.puts "Multiproc2"
    after 0 -> :ok
    end
  end
end
