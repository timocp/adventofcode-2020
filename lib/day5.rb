class Day5 < Base
  def part1
    seats.map(&:id).max
  end

  def part2
    ids = seats.map(&:id).sort
    (ids.first..ids.last).to_a - ids
  end

  def seats
    @seats ||= raw_input.split.map { |data| parse(data) }
  end

  Seat = Struct.new(:row, :column) do
    def id
      row * 8 + column
    end
  end

  def parse(data)
    Seat.new(
      data[0, 7].split("").reverse.map.with_index { |c, i| c == "B" ? 2**i : 0 }.sum,
      data[7, 3].split("").reverse.map.with_index { |c, i| c == "R" ? 2**i : 0 }.sum
    )
  end
end
