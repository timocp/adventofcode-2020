class Day6 < Base
  def part1
    raw_input.split("\n\n").map { |answers| answers.delete("\n").each_char.uniq.size }.sum
  end

  def part2
    raw_input.split("\n\n").map do |answers|
      counter = Hash.new(0)
      answers.split.each do |answer|
        answer.split("").each { |q| counter[q] += 1 }
      end
      counter.values.count { |v| v == answers.lines.size }
    end.sum
  end
end
