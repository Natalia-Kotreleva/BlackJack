# frozen_string_literal: true

class Card
  attr_accessor :rank, :suit, :value

  SUIT = %w[♠ ♥ ♦ ♣].freeze
  RANK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'K', 'Q', 'A'].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    @value = @rank if @rank.is_a? Numeric
    @value = 10 if @rank.is_a? String
    @value = 11 if @rank == 'A'
    @value
  end
end
