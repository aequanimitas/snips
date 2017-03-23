defmodule Tracer do
  @doc """
  Prints out the expression and returns the result of the expression

  trace is meant to be only called during expansion phase, can still be called during run-time
  """
  defmacro trace(expr_ast) do
    # expr_ast received here is already quoted
    # so if you compute Tracer.trace(1 + 2), it becomes Tracer.trace(quote(do: 1 + 2))

    # expression as string instead of AST
    string_repr = Macro.to_string(expr_ast)

    quote do                                      
      result = unquote(expr_ast) 
      Tracer.print(unquote(string_repr), result)
      result
    end
  end

  def print(string_repr, result) do
    IO.puts "Result of #{string_repr} is: #{result}"
  end
end
