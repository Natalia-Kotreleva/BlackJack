# frozen_string_literal: true

class Player
  attr_accessor :hand, :exp

  def initialize
    @hand = Hand.new
    @exp = 100
  end

  def get_exp
    self.exp -= 10
  end

  def put_exp
    self.exp += 10
  end

  def win(bank)
    @exp += bank
  end

  def add_card(card)
    @hand.add_card(card)
  end

  def clear_hand
    @hand.clear_hand
  end

  def dealer_move(card)
    @hand.add_card(card) if @hand.cards_sum < 17
  end
end
