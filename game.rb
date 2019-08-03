# frozen_string_literal: true

load 'interface.rb'

class Game
  attr_accessor :bank

  include Interface

  def initialize
    @player = Player.new
    @dealer = Player.new
    @bank = Bank.new
  end

  def bet
    @player.get_exp
    @dealer.get_exp
    @bank.put_exp
    @bank.put_exp
  end

  def return_to_players
    @player.put_exp
    @dealer.put_exp
    @bank.get_exp
    @bank.get_exp
  end

  def begin_game
    @player.hand.clear_hand
    @dealer.hand.clear_hand
    @player.add_card
    @player.add_card
    @dealer.add_card
    @dealer.add_card
    bet
  end

  def keep_game
    if @dealer.exp.zero? || @player.exp.zero?
      show_cards_sum(@player)
      show_cards_sum(@dealer)
      score_message(@player)
      score_message(@dealer)
      @match = 0
    else
      case continue
      when 'n'
        @match = 0
      end
    end
  end

  def game_proccess
    @match ||= 1
    while @match != 0
      begin_game
      show_cards(@player)
      menu(@player, @dealer)
      result_message(results)
      show_results(@player, @dealer)
      keep_game
    end
  end

  def results
    pl_score = @player.hand.cards_sum
    d_score = @dealer.hand.cards_sum

    if pl_score <= 21 && (d_score < pl_score || d_score > 21)
      @player.win(@bank.bank)
      @bank.bank = 0
      return 1 # player win
    elsif pl_score > 21 && d_score > 21
      return 2 # player dealer lose
    elsif d_score <= 21 && (pl_score > 21 || pl_score < d_score)
      @dealer.win(@bank.bank)
      @bank.bank = 0
      return 3 # dealer win
    elsif pl_score == d_score && pl_score <= 21
      return_to_players
      return 4 # player dealer win
    end
  end
end
