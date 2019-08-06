# frozen_string_literal: true

class Deck
  attr_accessor :deck_shuffle

  def initialize
    deck
  end

  def deck
    @deck = []
    Card::SUIT.each do |suit|
      Card::RANK.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck
  end

  def card
    @deck_shuffle << @deck_shuffle.shift
    @deck_shuffle.last
  end

  def shuffle
    @deck_shuffle = @deck.sort_by { rand }
  end
end
