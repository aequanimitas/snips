ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule QuoteFragmentTest do
  use ExUnit.Case

  test "expression still not semantically verified, doesn't throw error, final code not yet emitted" do
    assert quote(do: 1 + [] <> 9000)
  end

  test "quoted expression throws error after evaluation" do
    assert catch_error(quote(do: 1 + [] <> 9000) |> Code.eval_quoted)
  end

  test "by fragments, imagine this is a 'basic building block' for bigger nested structures" do
    sum_expr = quote(do: a + b)
    bind_expr = quote do a = 1; b = 2 end
    final_expr = quote do unquote(bind_expr); unquote(sum_expr) end
    {result, _bindings} = Code.eval_quoted(final_expr)
    assert result == 3
  end

  test "unquote evaluates immediately the expression" do
    assert 3 == quote(do: unquote(1 + 2))
  end

  test "unquote injects the result of the evaluated expression to the expression you're building" do
    a = 10
    b = 20
    assert 30 == quote(do: unquote(a + b))
    assert "a + b" == Macro.to_string(quote(do: a + b))
  end

  test "when injecting values, unquote can only translate and insert atoms, numbers, lists, strings and two-element tuples" do
    valid_exprs = [
      {:a, &is_atom/1}, 
      {1, &is_number/1}, 
      {[1,2,3], &is_list/1},
      {"hec", &is_bitstring/1},
      {{:ok, 1}, &is_tuple/1}
    ]

    Enum.each(valid_exprs, fn {val, func} ->
      val = quote(do: unquote(val)) |> Code.eval_quoted |> elem(0)
      assert func.(val)
    end)

    explicit_conversion_exprs = [
      {CompileError, ~r"invalid quoted expression", {:ok, [1,2,3], %{}}},
      {CompileError, ~r"invalid quoted expression", %{a: 1}},
      {ArgumentError, ~r"argument error", {:ok, :ok, :ok}}
    ]

    Enum.each(explicit_conversion_exprs, fn {err_mod, message, val} ->
      assert_raise err_mod, message, fn ->
        Code.eval_quoted quote(do: unquote(val))
      end
    end)
  end

  test "unquote can translate and insert other types with the help of Macro.escape, via explicit conversion" do
    assert quote(do: unquote(Macro.escape({1,2,3}))) |> Code.eval_quoted |> Kernel.tuple_size() == 2
  end

  # hold this test for now until you figure out how to properly catch the error
  # test "unquote checks current context" do
  #   assert_raise CompileError, fn ->
  #     quote(do: unquote(case x > 10 do true -> 1; false -> 0 end))
  #   end
  # end
end
