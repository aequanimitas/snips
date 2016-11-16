defmodule Cards do
  def create_deck do
    card_value = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    card_suits = ["Spades", "Clubs", "Diamonds", "Hearts"]

    for suit <- card_suits, value <- card_value do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck) 
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
end
