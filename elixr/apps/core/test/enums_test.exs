defmodule Core.EnumsTest do
  use ExUnit.Case, async: true

  alias Core.Enums

  test "Numbers" do
    # 64-bit IEEE 754-1985 'double-precision' representation
    float_1 = 0.00000000000000000127808167296182768961239867679641
    float_2 = 0.0000000000000000012780816729618276896
    assert float_1 == float_2
  end

  test "List / Enum exploration" do
    assert Enums.flatten([3]) == [3]
    assert Enums.flatten([[3]]) == [3]
    assert Enums.flatten([[[3]]]) == [3]
    assert Enums.flatten([[3], 3]) == [3, 3]
    assert Enums.flatten([[3], [[4]]]) == [3, 4]
    assert Enums.flatten([[3], [[4]], [[2] | [[[3]]]]]) == [3, 4, 3, 2]
    assert Enums.len([1,2,3,4]) == 4
    assert is_tuple(hd(Enums.zip([1,2,3,4]))) == true
    assert is_list(Enums.zip([1,2,3,4])) == true
  end

  test "Binaries" do
    assert '😀' == [128_512]
    # how do you test the zero-width joiner?
  end
end
