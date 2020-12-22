class Day15 < Base
  def part1
    play.take(2020).last
  end

  def play
    return to_enum(:play) unless block_given?

    input = raw_input.split(",").map(&:to_i)

    most_recent = nil
    seen = {} # array of last 2 rounds spoken

    (1..).each do |round|
      output = if (i = input.shift)
                 i
               elsif seen[most_recent].size == 1
                 0
               else
                 seen[most_recent][1] - seen[most_recent][0]
               end
      yield output
      seen[output] = if seen.key?(output)
                       [seen[output].last, round]
                     else
                       [round]
                     end
      most_recent = output
    end
  end
end
