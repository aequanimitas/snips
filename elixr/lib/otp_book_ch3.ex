defmodule Elixr.TheLittleElixir.Etex.Worker do

  @doc """
  - Store the results into the mailbox of the sender

  # get the reference to the module and function first
  # the empty array in the end are parameters
  iex> pid = spawn(Elixr.Etex.Worker, :loop, [])

  # send the message to the destination, in this case a local PID
  iex> send(pid, {self, "Manila"})

  iex> Enum.each(["Manila", "Tokyo", "Kuala Lumpur"], fn d ->
         pid = spawn(Elixr.Etex.Worker, :loop, [])
         send(pid, {self(), d)
       end)
  # show the messages that were sent
  # the order here is not assured
  iex> flush
  {:ok, "Manila: 24.9 C"} 
  {:ok, "Tokyo: 7.1 C"} 
  {:ok, "Kuala Lumpur: 28.9 C"} 
  :ok
  """

  def loop do
    receive do
      {sender_pid, location} ->
        send(sender_pid, {:ok, temperature_of(location)})
      _ ->
        IO.puts "Unknown input"
    end
    # call itself again, recursive fn
    # when left out, the moment a message arrives (the process starts to handle a message), 
    # it will exit and be garbage collected
    # 
    loop
  end

  def temperature_of(location) do
    result = url_for(location) |> HTTPoison.get |> parse_response
    case result do
      {:ok, temp} ->
        "#{location}: #{temp} C"
      :error ->
        "#{location} not found"
    end
  end

  def url_for(location) do
    # "San Antonio" == "San%20Antonio"
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end

  # destructure the response
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  # if it doesn't match, do the catch-all fn, check ```with``` code in sulat
  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp apikey() do
    # read api key directly from file for now
    {_, key} = File.read("lib/otpbook_openweatherapikey")  
    key |> String.replace("\n", "")
  end
end
