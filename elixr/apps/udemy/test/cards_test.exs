defmodule Udemy.CardsTest do
  use ExUnit.Case
  doctest Udemy.Cards

  test "create_deck makes 52 cards" do
    deck_length = length(Udemy.Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Udemy.Cards.create_deck
    refute deck == Udemy.Cards.shuffle(deck)
  end
end
