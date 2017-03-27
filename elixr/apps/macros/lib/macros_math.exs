defmodule Macros.Math do

  # macros receive the AST representation
  # so 1 + 1 is converted to AST: {:+, [context: Elixir, import: Kernel], [1,2]}
  # by pattern matching
  defmacro say(args = {:+, _, [lhs, rhs]}) do
    quote do
      # all labels that were used in desctructuring seems "unavailable" until doing
      # an ```unquote```. Code below throws error
      # IO.puts args 
      lhs = unquote lhs
      rhs = unquote rhs
      result = lhs + rhs
      IO.puts "#{lhs} + #{rhs} is #{result}"
      result
    end
  end

  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote lhs
      rhs = unquote rhs
      result = lhs * rhs
      IO.puts "#{lhs} * #{rhs} is #{result}"
      result
    end
  end

  defmacro say({:-, _, [lhs, rhs]}) do
    quote do
      lhs = unquote lhs
      rhs = unquote rhs
      result = lhs - rhs
      IO.puts "#{lhs} - #{rhs} is #{result}"
      result
    end
  end
end
