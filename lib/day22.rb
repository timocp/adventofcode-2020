class Day22 < Base
  def part1
    parse
    play
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

  def dbg(text = "")
    # puts text
  end

  def parse
    @deck = raw_input.split("\n\n").map { |data| data.each_line.to_a[1..].map(&:to_i) }
  end
end
