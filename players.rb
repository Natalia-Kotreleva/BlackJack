# frozen_string_literal: true

class Players
  attr_accessor :cards, :exp

  def initialize
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

  def cards_create(card1, card2)
    @cards = []
    @cards << card1
    @cards << card2
  end

  def add_card_player(card3)
    @cards << card3
  end

  def cards_sum(deck_for_sum)
    sum = 0
    @cards.each do |card|
      sum += deck_for_sum[card]
    end
    if sum > 21
      @cards.each do |card|
        sum -= 10 if deck_for_sum[card] == 11
      end
    end
    sum
  end

  def dealer_move(card3, deck_for_sum)
    if cards_sum(deck_for_sum) < 17
      @cards << card3
      puts 'Дилер взял карту'
    else
      puts 'Дилер не взял карту'
  end
  end
end
