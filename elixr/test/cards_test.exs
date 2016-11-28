defmodule Elixr.CardsTest do
  use ExUnit.Case
  doctest Elixr.Cards

  test "create_deck makes 52 cards" do
    deck_length = length(Elixr.Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Elixr.Cards.create_deck
    refute deck == Elixr.Cards.shuffle(deck)
  end
end
