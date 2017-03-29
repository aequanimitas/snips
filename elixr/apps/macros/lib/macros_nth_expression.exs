defmodule Macros do
  defmacro my_and(fst, snd) do
    quote do
      if (unquote(fst) == true) do
        nil
      else
        unquote(snd)
      end
    end
  end

  defmacro nth_expression(nth, expressions) do
    quote do
      loop = fn (nth, counter, [h | t], func) ->
        cond do
          nth == counter -> h
          counter > nth ->
            nil
          true ->
            func.(nth, counter + 1, t, func)
        end
      end
      loop.(unquote(nth), 0, unquote(expressions), loop)
    end
  end
end
