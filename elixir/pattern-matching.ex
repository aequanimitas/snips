defmodule Beer do
  def abv(:redhorse) do
      "6.9%"
  end

  def abv(:pilsen) do
    "5%" 
  end

  def abv(:strongice) do
    "6.3%" 
  end

  def abv(:flavored) do
    "3%" 
  end

  def abv(:cervezanegra) do
    "3%" 
  end

  def abv(:light) do
    "5%" 
  end

  def abv(name) do
    "Unknown beer: #{name}" 
  end
end

ExUnit.start

defmodule BeerTest do
  use ExUnit.Case, async: true

  test 'redhorse' do
    assert Beer.abv(:redhorse) == "6.9%"
  end

  test 'pilsen' do
    assert Beer.abv(:pilsen) == "5%"
  end

  test 'strongice' do
    assert Beer.abv(:strongice) == "6.3%"
  end

  test 'flavored' do
    assert Beer.abv(:flavored) == "3%"
  end

  test 'cerveza negra' do
    assert Beer.abv(:cervezanegra) == "3%"
  end

  test 'light' do
    assert Beer.abv(:light) == "5%"
  end

  test 'ror' do
    assert Beer.abv(:ror) == "Unknown beer: ror"
  end
end

defmodule NoobPatternMatchingTest do
  use ExUnit.Case, async: true
  test "unpack / destructure" do
    # constants
    [a, b] = [10, 20]
    assert 10 == a
    assert 20 == b
  end

  test "Matching errors" do
    assert_raise MatchError, fn -> 
      [a,1,c] = [1,2,3]
    end
  end

  test "Variables bind once (per match)" do
    assert_raise MatchError, fn -> 
      [a, a] = [1,2]
    end
  end

  test "Pin operator" do
    assert_raise MatchError, fn -> 
      a = 10
      [^a, b] = [1,2]
    end
  end

  test "Variables can be re-binded on the next expression" do
    a = 10
    a = 20
    assert a == 20
  end

  test "Opening a file that doesn't exist" do
    # eRROR no entRY
    assert {:error, :enoent} = File.read('lol.txt')
  end
end
