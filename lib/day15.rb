class Day15 < Base
  def part1
    play(2020)
  end

  def part2
    play(30_000_000)
  end

  def play(stop)
    input = raw_input.split(",").map(&:to_i)

    most_recent = nil
    output = nil
    seen = {} # last round seen

    (1..stop).each do |round|
      output = if input.any?
                 input.shift
               elsif seen.key?(most_recent)
                 round - seen[most_recent]
               else
                 0
               end
      seen[most_recent] = round
      most_recent = output
    end
    most_recent
  end
end
