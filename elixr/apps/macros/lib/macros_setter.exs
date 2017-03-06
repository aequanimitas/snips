defmodule Setter do
  defmacro bind_name(str) do
    quote do
      name = unquote str
    end
  end
end

# let it leak, override name in caller's context
# what happens if name doesn't exist?: it creates a new variable in context
defmodule SetterTwo do
  defmacro bind_name(str) do
    quote do
      var!(name) = unquote str
    end
  end
end
