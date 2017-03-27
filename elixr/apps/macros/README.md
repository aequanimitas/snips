# Macros

Notes and collection of codes while exploring Elixir macros

### Basic terminology

- **Macros** -
  a rule or pattern that specifies how a specific input sequence maps out to a output sequence
- **Macro Expansion** -
  the process where the macro is transformed into a specific output sequence
- **quote** - retrieves the representation of any **expression**
- **Macro.escape** - recursively escapes value so that it can be inserted into the AST. **Escaping** means to get the alternative representation of an expression. **quote** and **Macro.escape** both return the representation of expressions. The differences are:
  -
  -
- **unquote** - is used to inject a **value** inside a **quoted expression**, typically used inside **quote**
  and also assumes that the **value** is a **valid quoted expression (atom, list, number, string, 2-elem tuple).**

Macros in Elixir convert **code** and **values** into **data**(*quoted expression*) that can be used by Erlang to produce the bytecode. **Code** and **values** has inner representation in
Elixir


If the **passed value** is not a **valid quoted expression**, it can still be expressed as a **quoted expression**. This is where **Macro.escape comes in**, when we need to insert values that are invalid quoted expression
```
# difference between a valid quoted expression and other data types
# this just returns the value
iex> Macro.escape(quote(do: 1))
1
# this returns the raw AST
iex> Macro.escape(quote(do: %{a: 1}))
{:%{}, [], [a: 1]}
# example from https://elixirforum.com/t/understand-macro-escape/405, thanks Nobbz!

iex(1)> defmodule(Foo, do: def(bar, do: [1,2,3]))
{:module, Foo, <<...>>, {:bar, 0}}
iex(2)> Foo.bar
[1, 2, 3]
iex(3)> quote do: Foo.bar
{{:., [], [{:__aliases__, [alias: false], [:Foo]}, :bar]}, [], []}
iex(4)> Macro.escape(Foo.bar)
[1, 2, 3]
iex(5)> quote do: [1,2,3]
[1, 2, 3]
```


```
iex> defmodule Foo, do: defmacro bar(x), quote do: unquote(x) * unquote(x)

# require the module first, guarantees its implementation is available
# during compile time, specifically in the macro expansion time
#
# During MET/Pre-processing, the only available data is the source code,
# and since it is still not running, no value of x is bound to the code.
#
# The defmacro receives an AST representation of the arguments passed to it
# in this case, x will result to an AST: {:x, [], Elixir}, you can also use # pattern matching here.
#
# Since an AST is required by the compiler, we use quote to return an
# AST inside the macro

iex> require Foo
iex> Foo.bar(10)
100
```
