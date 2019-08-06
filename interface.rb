# frozen_string_literal: true

class Interface
  def menu(player, dealer, card)
    puts 'Пропустить ход (1), добавить карту(2), открыть карты(3)?'
    choice = gets.to_i
    while choice != 4
      case choice
      when 0
        puts 'Добавить карту(2), открыть карты(3)?'
        choice = gets.to_i
      when 1
        dealer.dealer_move(card)
        choice = 0
      when 2
        player.add_card(card)
        show_cards(player)
        dealer.dealer_move(card)
        choice = 4
      when 3
        choice = 4
      end
    end
  end

  def show_cards(player)
    player.hand.cards.each do |card|
      puts "#{card.rank} #{card.suit}"
    end
  end

  def show_results(player, dealer)
    puts "Счет игрока: #{player.hand.cards_sum}, банк игрока: #{player.exp}"
    puts "Счет дилера: #{dealer.hand.cards_sum}, банк дилера: #{dealer.exp}"
  end

  def win_message
    puts 'Вы выиграли!'
  end

  def lose_message
    puts 'Вы проиграли!'
  end

  def draw_message
    puts 'Ничья!'
  end

  def continue
    puts 'Продолжить игру? (y/n)'
    choice = gets.chomp
  end

  def result_message(num)
    case num
    when 1
      win_message
    when 2
      lose_message
    when 3
      lose_message
    when 4
      draw_message
    end
  end
end
