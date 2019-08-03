# frozen_string_literal: true

# class
module Deck
  SUIT = %w[♠ ♥ ♦ ♣].freeze

  rank1 = [2, 3, 4, 5, 6, 7, 8, 9, 10]
  rank2 = %w[J K Q]
  rank_with_value = {}
  rank1.each do |rank|
    key = rank
    rank_with_value[key] = rank
  end
  rank2.each do |rank|
    key = rank
    rank_with_value[key] = 10
  end
  (0..3).each do |_i|
    key = 'A'
    rank_with_value[key] = 11
  end

  DECK = rank_with_value
end
