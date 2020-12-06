class Day6 < Base
  def part1
    raw_input.split("\n\n").map { |answers| answers.delete("\n").each_char.uniq.size }.sum
  end
end
