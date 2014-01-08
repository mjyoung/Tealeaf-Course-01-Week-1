require 'pry'

def start_game
  current_deck = [
    ["Ace",   "Clubs"], ["Ace",   "Diamonds"], ["Ace",   "Hearts"], ["Ace",   "Spades"],
    ["King",  "Clubs"], ["King",  "Diamonds"], ["King",  "Hearts"], ["King",  "Spades"],
    ["Queen", "Clubs"], ["Queen", "Diamonds"], ["Queen", "Hearts"], ["Queen", "Spades"],
    ["Jack",  "Clubs"], ["Jack",  "Diamonds"], ["Jack",  "Hearts"], ["Jack",  "Spades"],
    ["2",     "Clubs"], ["2",     "Diamonds"], ["2",     "Hearts"], ["2",     "Spades"],
    ["3",     "Clubs"], ["3",     "Diamonds"], ["3",     "Hearts"], ["3",     "Spades"],
    ["4",     "Clubs"], ["4",     "Diamonds"], ["4",     "Hearts"], ["4",     "Spades"],
    ["5",     "Clubs"], ["5",     "Diamonds"], ["5",     "Hearts"], ["5",     "Spades"],
    ["6",     "Clubs"], ["6",     "Diamonds"], ["6",     "Hearts"], ["6",     "Spades"],
    ["7",     "Clubs"], ["7",     "Diamonds"], ["7",     "Hearts"], ["7",     "Spades"],
    ["8",     "Clubs"], ["8",     "Diamonds"], ["8",     "Hearts"], ["8",     "Spades"],
    ["9",     "Clubs"], ["9",     "Diamonds"], ["9",     "Hearts"], ["9",     "Spades"],
    ["10",    "Clubs"], ["10",    "Diamonds"], ["10",    "Hearts"], ["10",    "Spades"]
  ]

  # from solutions video...
  # better code for the above would have been:
  # suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
  # cards = ["Ace", "King", "Queen", "Jack", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
  # current_deck = cards.product(suits)

  player_hand = current_deck.sample(2)
  current_deck.delete(player_hand[0])
  current_deck.delete(player_hand[1])

  dealer_hand = current_deck.sample(2)
  current_deck.delete(dealer_hand[0])
  current_deck.delete(dealer_hand[1])

  current_turn = "player"

  {player_hand: player_hand,   dealer_hand: dealer_hand, 
   current_deck: current_deck, current_turn: current_turn}
end

def calculate_total(hand)
  hand_total = 0
  hand.each do |card|
    case card[0]
    when "Ace" 
      hand_total += 11
    when "King", "Queen", "Jack"  # same as || which is not valid in a case statement
      hand_total += 10
    else
      hand_total += card[0].to_i
    end
  end

  # correct for aces if total > 21
  ace_array = hand.map { |card| card[0] }

  ace_array.select{ |card| card == "Ace" }.count.times do
    hand_total -= 10 if hand_total > 21
  end

  hand_total
end

def hit_or_stay(current_deck, hand, current_turn)
  while true
    if current_turn == "player"
      puts "Would you like to [H]it or [S]tay?" 
      response = gets.chomp.upcase
      case response
      when "H"
        random_card = current_deck.sample(1)[0]
        hand << random_card
        current_deck.delete(random_card)
        total = calculate_total(hand)
        puts "You Hit! Your total is #{total}. Your cards are: "         
        hand.each { |card| puts "#{card[0]} of #{card[1]}" }
        game_over = check_if_game_over(hand, total, current_turn)
        break if game_over == 1
      when "S"
        total = calculate_total(hand)
        puts "You Stay! Your total is #{total}. Your cards are: "      
        hand.each { |card| puts "#{card[0]} of #{card[1]}" }
        break
      else puts "Please press [H]it or [S]tay"
      end
    else
      total = calculate_total(hand)
      if total < 17
        random_card = current_deck.sample(1)[0]
        hand << random_card
        current_deck.delete(random_card)
        total = calculate_total(hand)
        puts "Dealer hits! Dealer's total is #{total}. Dealer's cards are: "  
        hand.each { |card| puts "#{card[0]} of #{card[1]}" }
        game_over = check_if_game_over(hand, total, current_turn)
        break if game_over == 1
      else 
        puts "Dealer stays! Dealer's total is #{total}. Dealer's cards are: " 
        hand.each { |card| puts "#{card[0]} of #{card[1]}" }
        break
      end
    end
  end

  hit_or_stay_hash = { current_deck: current_deck, hand: hand, 
                       total: total, game_over: game_over }
end

def check_if_game_over(hand, total, current_turn)
  if hand.size == 2 && total == 21 && current_turn == "player"
    puts "Blackjack! You win!"
    current_turn = "nobody"
  elsif hand.size > 2 && total > 21 && current_turn == "player"
    puts "You BUST! Dealer wins!"
    current_turn = "nobody"
  elsif total == 21 && current_turn == "dealer"
    puts "Dealer has 21! Dealer wins!"
    current_turn = "nobody"
  elsif total > 21 && current_turn == "dealer"
    puts "Dealer BUSTS! You win!"
    current_turn = "nobody"
  end
  game_over = 1 if current_turn == "nobody"
end

def determine_winner(player_total, dealer_total)
  puts player_total > dealer_total || dealer_total > 21 ? "You win!" : "Dealer wins!"
end

puts "What is your name?"
player_name = gets.chomp

puts "Welcome to the table, #{player_name}. Let's play Blackjack!"

while true

  start_hash = start_game
  player_hand = start_hash[:player_hand]
  dealer_hand = start_hash[:dealer_hand]
  current_deck = start_hash[:current_deck]
  current_turn = start_hash[:current_turn]

  player_total = calculate_total(player_hand)
  dealer_total = calculate_total(dealer_hand)

  puts "#{player_name}\'s hand consists of: "
  player_hand.each { |card| puts "#{card[0]} of #{card[1]}" } 

  puts "Dealer shows one card face up: "
  puts "#{dealer_hand.first[0]} of #{dealer_hand.first[1]}"

  game_over = check_if_game_over(player_hand, player_total, current_turn)

  if game_over != 1
    hit_or_stay_hash = hit_or_stay(current_deck, player_hand, current_turn)
    current_deck = hit_or_stay_hash[:current_deck]
    player_hand = hit_or_stay_hash[:hand]
    player_total = hit_or_stay_hash[:total]
    game_over = hit_or_stay_hash[:game_over]
  end

  if game_over != 1
      current_turn = "dealer"
      game_over = check_if_game_over(dealer_hand, dealer_total, current_turn)
      if game_over != 1
        hit_or_stay_hash = hit_or_stay(current_deck, dealer_hand, current_turn)
        current_deck = hit_or_stay_hash[:current_deck]
        dealer_hand = hit_or_stay_hash[:hand]
        dealer_total = hit_or_stay_hash[:total] 
        game_over = hit_or_stay_hash[:game_over]

        current_turn = "nobody"
        determine_winner(player_total, dealer_total) if game_over != 1
      end
  end

  puts "Would you like to play another game? [Y] or [N]"
  
  another_game = gets.chomp.upcase
  case another_game
  when "Y"
  when "N"
    break
  end

end
  
# need to refactor code
# also need to get the "Ace" counting right 
