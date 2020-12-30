require "set"

class Day22 < Base
  def part1
    parse
    play
    winning_players_score
  end

  def part2
    parse
    dbg
    play_recursive(@deck)
    winning_players_score
  end

  def play
    (1..).each do |round|
      dbg "-- Round #{round} --"
      dbg "Player 1's deck: #{@deck[0].join(", ")}"
      dbg "Player 2's deck: #{@deck[1].join(", ")}"
      cards = @deck.map(&:shift)
      dbg "Player 1 plays: #{cards[0]}"
      dbg "Player 2 plays: #{cards[1]}"
      if cards[0] > cards[1]
        dbg "Player 1 wins the round!"
        @deck[0] += cards
      else
        dbg "Player 2 wins the round!"
        @deck[1] += cards.reverse
      end
      dbg
      break if @deck.any?(&:empty?)
    end
  end

  def winning_players_score
    @deck.detect(&:any?).reverse.map.with_index(1) { |card, index| card * index }.sum
  end

  # returns the winning player of this game
  def play_recursive(deck)
    @game = (@game || 0) + 1
    seen ||= Set.new

    game = @game
    dbg "=== Game #{game} ==="

    (1..).each do |round|
      dbg
      dbg "-- Round #{round} (Game #{game}) --"
      dbg "Player 1's deck: #{deck[0].join(", ")}"
      dbg "Player 2's deck: #{deck[1].join(", ")}"
      key = deck[0] + [-1] + deck[1]
      if seen.include?(key)
        dbg "This deck has been seen before in this game!  Giving game #{game} to Player 1"
        return 0
      else
        seen.add(key)
      end
      cards = deck.map(&:shift)
      dbg "Player 1 plays: #{cards[0]}"
      dbg "Player 2 plays: #{cards[1]}"
      winner = if cards[0] <= deck[0].size && cards[1] <= deck[1].size
                 dbg "Playing a sub-game to determine the winner..."
                 dbg
                 play_recursive([deck[0][0, cards[0]], deck[1][0, cards[1]]]).tap do
                   dbg "...anyway, back to game 1"
                 end
               elsif cards[0] > cards[1]
                 0
               else
                 1
               end
      dbg "Player #{winner + 1} wins round #{round} of game #{game}!"
      deck[winner] += winner.zero? ? cards : cards.reverse
      break if deck.any?(&:empty?)
    end

    if deck[0].empty?
      dbg "The winner of game #{game} is player 2!"
      dbg
      1
    else
      dbg "The winner of game #{game} is player 1!"
      dbg
      0
    end
  end

  def dbg(text = "")
    # puts text
  end

  def parse
    @deck = raw_input.split("\n\n").map { |data| data.each_line.to_a[1..].map(&:to_i) }
  end
end
