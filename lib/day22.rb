require "set"

class Day22 < Base
  def part1
    parse
    play
    winning_players_score
  end

  def part2
    parse
    play_recursive(@deck)
    winning_players_score
  end

  def play
    (1..).each do
      cards = @deck.map(&:shift)
      if cards[0] > cards[1]
        @deck[0] += cards
      else
        @deck[1] += cards.reverse
      end
      break if @deck.any?(&:empty?)
    end
  end

  def winning_players_score
    @deck.detect(&:any?).reverse.map.with_index(1) { |card, index| card * index }.sum
  end

  # returns the winning player of this game
  def play_recursive(deck)
    seen = Set.new

    (1..).each do
      key = (deck[0] + [-1] + deck[1]).join(",")
      return 0 if seen.include?(key)

      seen.add(key)
      cards = deck.map(&:shift)
      winner = if cards[0] <= deck[0].size && cards[1] <= deck[1].size
                 d0 = deck[0].take(cards[0])
                 d1 = deck[1].take(cards[1])
                 if d0.max > d1.max
                   0 # P1 has to win this subgame
                 else
                   play_recursive([deck[0].take(cards[0]), deck[1].take(cards[1])])
                 end
               elsif cards[0] > cards[1]
                 0
               else
                 1
               end
      deck[winner] += winner.zero? ? cards : cards.reverse
      return 1 if deck[0].empty?
      return 0 if deck[1].empty?
    end
  end

  def parse
    @deck = raw_input.split("\n\n").map { |data| data.each_line.to_a[1..].map(&:to_i) }
  end
end
