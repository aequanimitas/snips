defmodule Core.UsingBitwiseTest do
  use ExUnit.Case
  use Bitwise

  test "odd numbers" do
    assert Bitwise.band(1, 0x1) == 1
    assert Bitwise.band(2, 0x1) == 0
    assert Bitwise.band(1_978_691_728_068_938, 0x1) == 0
  end
end
