defmodule Udemy.Cards do
  @moduledoc """
    Provides methods for creating and handling deck of cards
  """ 

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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

  @doc """
    Determines where a deck contains a given card

  ## Examples

    iex> Udemy.Cards.contains?(Udemy.Cards.create_deck(), "Ace of Malunggay")
    false  

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. The `handsize` argument indicated
    how many cards should be in the hand

  ## Examples

    iex> deck = Udemy.Cards.create_deck()
    iex> {hand, _deck} = Udemy.Cards.deal(deck, 1) # for pusoy
    iex> hand
    ["Ace of Spades"]

  """
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

  def create_hand(handsize) do
    Udemy.Cards.create_deck
    |> Udemy.Cards.shuffle
    |> Udemy.Cards.deal(handsize) # 1st argument automatically passed, handsize is 2nd arg
  end
end
