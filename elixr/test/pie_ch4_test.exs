defmodule Elixr.PIE.LinkedListTest do
  use ExUnit.Case, async: true

  alias Elixr.PIE.LinkedList.Elem, as: LLE

  test "structure" do
    first = %LLE{value: 1}
    second = %LLE{value: 2}
    first = %{first | next: second}
    assert first.__struct__ == Elixr.PIE.LinkedList.Elem
    assert first.next.__struct__ == Elixr.PIE.LinkedList.Elem
  end

  test "next is nil by default" do
    first = %LLE{value: 1}
    second = %LLE{value: 2}
    assert first.next == nil
    first = %{first | next: second}
    assert first.next.next == nil
  end
end
