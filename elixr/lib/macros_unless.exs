defmodule Elixr.ControlFlow do

  # always receives and sends back an AST representation, things to note:
  # - you can still do pattern matching in macro arguments
  # - quote generates an AST, 
  # - labels here are still not injected back into the AST, use ```unquote``` to 
  #   insert it back into the AST 
  # - produced code will contains an ```if !``` everywhere it is used
  # - returned AST is expanded inside the caller's context at compile time
  # - compiler keeps on expanding the the returned expression until it is not AST

  defmacro unless(expression, do: block) do
    quote do
      # inject outside bound variables into the AST
      # ```if``` is internally represented as a ```case``` expression
      if !(unquote(expression)), do: unquote(block)
    end
  end

  def expanded_once do
    ast = quote do
      ControlFlow.unless 2 == 3, do: "block entered"
    end
    Macro.expand_once(ast, __ENV__)
  end
end
