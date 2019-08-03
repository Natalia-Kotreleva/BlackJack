# frozen_string_literal: true

load 'deck.rb'

class Card
  attr_accessor :rank, :suit, :value

  def initialize
    @rank = Deck::DECK.keys.sample
    @suit = Deck::SUIT.sample
    @value = Deck::DECK[@rank]
  end
end
