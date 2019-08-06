# frozen_string_literal: true

class Game
  def initialize
    @player = Player.new
    @dealer = Player.new
    @bank = Bank.new
    @deck = Deck.new
    @interface = Interface.new
  end

  def game_proccess
    @match ||= 1
    while @match != 0
      begin_game
      @interface.show_cards(@player)
      @interface.menu(@player, @dealer, @deck.card)
      @interface.result_message(results)
      @interface.show_results(@player, @dealer)
      keep_game
    end
  end

  private

  def for_users(method)
    [@player, @dealer].each { |user| user.send(method) }
  end

  def users_add_card
    [@player, @dealer].each { |user| user.add_card(@deck.card) }
  end

  def bet
    for_users('get_exp')
    @bank.put_exp
    @bank.put_exp
  end

  def return_to_players
    for_users('put_exp')
    @bank.get_exp
    @bank.get_exp
  end

  def begin_game
    for_users('clear_hand')
    @deck.shuffle
    users_add_card
    users_add_card
    bet
  end

  def keep_game
    if @dealer.exp.zero? || @player.exp.zero?
      @interface.show_cards_sum(@player)
      @interface.show_cards_sum(@dealer)
      @interface.score_message(@player)
      @interface.score_message(@dealer)
      @match = 0
    else
      case @interface.continue
      when 'n'
        @match = 0
      end
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
