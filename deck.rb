# frozen_string_literal: true

class Deck
  attr_accessor :deck

  def initialize
    deck_create
  end

  def deck_create
    rank1 = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    rank2 = %w[J K Q]
    suit = %w[♠ ♥ ♦ ♣]
    @deck = {}
    suit.each do |s|
      rank1.each do |value|
        key = value.to_s + ' ' + s.to_s
        @deck[key] = value
      end
    end
    suit.each do |s|
      rank2.each do |value|
        key = value.to_s + ' ' + s.to_s
        deck[key] = 10
      end
    end
    suit.each do |s|
      key = 'A ' + s.to_s
      @deck[key] = 11
    end
    @deck
  end

  def rand_card
    rand_card = @deck.keys.sample
    @deck.delete(rand_card)
    rand_card
  end

  def redeck
    deck_create
  end
end
