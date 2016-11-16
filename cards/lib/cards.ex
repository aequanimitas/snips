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

  def deal(deck, hand_size) do
    # returns a tuple, { hand, deck }
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
  
  def load(filename) do
    case File.read(filename) do
      # comparison and assignment on clauses
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "File doesn't exist"
    end
  end
end
