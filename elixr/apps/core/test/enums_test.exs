defmodule Core.Core.EnumsTest do
  use ExUnit.Case, async: true

  test "Numbers" do
    #assert_raise SyntaxError, fn -> x = .0000000000000000000000000000023432432432432234232324 end
    # 64-bit IEEE 754-1985 'double-precision' representation
    assert 0.0000000000000000012780816729618276896 == 0.00000000000000000127808167296182768961239867679641
  end

  test "Aliases and atoms" do
    assert :true == true
    assert :false == false
    assert nil == :nil
  end

  test "List / Enum exploration" do
    assert Core.Enums.flatten([3]) == [3]
    assert Core.Enums.flatten([[3]]) == [3]
    assert Core.Enums.flatten([[[3]]]) == [3]
    assert Core.Enums.flatten([[3], 3]) == [3, 3]
    assert Core.Enums.flatten([[3], [[4]]]) == [3, 4]
    assert Core.Enums.flatten([[3], [[4]], [[2] | [[[3]]]]]) == [3, 4, 3, 2]
    assert Core.Enums.len([1,2,3,4]) == 4
    assert is_tuple(hd(Core.Enums.zip([1,2,3,4]))) == true
    assert is_list(Core.Enums.zip([1,2,3,4])) == true
  end

  test "Binaries" do
    assert '😀' == [128512]
    # how do you test the zero-width joiner?    
  end
end
