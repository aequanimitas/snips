# hygienic: doesn't leak variables, imports and aliases to caller's context
# accessing the caller's context needs to be explicit. I like this design because it forces
# you to be clear with your intentions and the way macros work in elixir, it's like a 
# nagging voice that asks you "are you really sure in doing this with the risk of clashing?"

# wrap ```ast``` 
ast_wrap = fn ->
  ast = quote do
    if meaning_of_life == 42 do
      "it's true"
    else
      "it remains to be seen"
    end
  end
  
  Code.eval_quoted ast, meaning_to_life: 42
end

# overriding hygiene
ast2 = quote do
  if var!(meaning_of_life) == 42 do
    "it's true"
  else
    "it remains to be seen"
  end
end

IO.puts "Before Code.eval_quoted:"
IO.puts inspect ast2

ast2_eval = Code.eval_quoted ast2, meaning_of_life: 42

IO.puts "After Code.eval_quoted"
IO.puts inspect ast2_eval
