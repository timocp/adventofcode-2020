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
    seen = {} # array of last 2 rounds spoken

    (1..stop).each do |round|
      output = if (i = input.shift)
                 i
               elsif seen[most_recent].size == 1
                 0
               else
                 seen[most_recent][1] - seen[most_recent][0]
               end
      seen[output] = if seen.key?(output)
                       [seen[output].last, round]
                     else
                       [round]
                     end
      most_recent = output
    end
    most_recent
  end
end
