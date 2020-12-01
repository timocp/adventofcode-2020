class Day1 < Base
  def part1
    find_sums(2020, 2).inject(:*)
  end

  def part2
    find_sums(2020, 3).inject(:*)
  end

  def find_sums(target, count)
    input_to_ints.combination(count) do |values|
      return values if values.inject(:+) == target
    end
    nil
  end
end
