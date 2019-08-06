# frozen_string_literal: true

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def clear_hand
    @cards = []
  end

  def cards_sum
    sum = 0
    @cards.each { |card| sum += card.value }
    if sum > 21
      @cards.each do |card|
        sum -= 10 if card.rank == 'A'
      end
    end
    sum
  end
end
