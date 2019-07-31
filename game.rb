# frozen_string_literal: true

class Game
  attr_accessor :bank

  def initialize
    @player = Players.new
    @dealer = Players.new
    @bank = Bank.new
    @deck_for_game = Deck.new
    @deck_for_sum = Deck.new
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
    @deck_for_game.redeck
    @player.cards_create(@deck_for_game.rand_card, @deck_for_game.rand_card)
    @dealer.cards_create(@deck_for_game.rand_card, @deck_for_game.rand_card)
    bet
    puts @player.cards
  end

  def keep_game
    if @dealer.exp.zero? || @player.exp.zero?
      puts "Конец игры! Банк дилера: #{@dealer.exp}, банк игрока: #{@player.exp}."
      @match = 0
    else
      puts 'Продолжить игру? (y/n)'
      choice = gets.chomp
      case choice
      when 'y'
        puts 'Ok!'
      when 'n'
        puts 'До встречи!'
        @match = 0
      end
  end
  end

  def choice
    puts 'Пропустить(1), добавить карту(2), открыть карты(3)?'
    choice = gets.to_i

    while choice != 4
      case choice
      when 0
        puts 'Добавить карту(2), открыть карты(3)?'
        choice = gets.to_i
      when 1
        @dealer.dealer_move(@deck_for_game.rand_card, @deck_for_sum.deck)
        choice = 0
      when 2
        @player.add_card_player(@deck_for_game.rand_card)
        puts @player.cards
        @dealer.dealer_move(@deck_for_game.rand_card, @deck_for_sum.deck)
        choice = 4
      when 3
        choice = 4
      end
    end
  end

  def game_proccess
    @match ||= 1
    while @match != 0
      begin_game
      choice
      results
      keep_game
    end
  end

  def results
    result = "Счет игрока: #{@player.cards_sum(@deck_for_sum.deck)}, счет дилера: #{@dealer.cards_sum(@deck_for_sum.deck)}"
    pl_score = @player.cards_sum(@deck_for_sum.deck)
    d_score = @dealer.cards_sum(@deck_for_sum.deck)

    if pl_score > 21 && d_score > 21
      puts "Игра окончена! #{result}"
    elsif pl_score <= 21 && (pl_score > d_score || d_score > 21)
      puts "Вы выиграли! #{result}"
      @player.win(@bank.bank)
      @bank.bank = 0
    elsif d_score <= 21 && (pl_score > 21 || pl_score < d_score)
      puts "Вы проиграли! #{result}"
      @dealer.win(@bank.bank)
      @bank.bank = 0
    elsif pl_score == d_score && pl_score <= 21
      puts "Ничья! #{result}"
      return_to_players

    end
    puts "Банк игрока: #{@player.exp}, банк дилера: #{@dealer.exp}, банк: #{@bank.bank}"
  end
end
