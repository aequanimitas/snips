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

defmodule AssertionTest do
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
