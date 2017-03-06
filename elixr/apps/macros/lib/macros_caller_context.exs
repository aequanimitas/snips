defmodule Mod do
  defmacro definfo do
    # Compilation maps __MODULE__ to Mod
    IO.puts "Current scope in macro's context: #{__MODULE__}"
    quote do
      # Compilation maps __MODULE__ to __MyModule__
      IO.puts "Current scope in caller's context: #{__MODULE__}"
      def friendly_info do
        IO.puts """
        My name is #{__MODULE__}
        My functions are #{inspect __info__(:functions)}
        """
      end
    end
  end
end

defmodule MyModule do
  # when required here, the scope is changed to Elixir.MyModule
  require Mod
  Mod.definfo
end
