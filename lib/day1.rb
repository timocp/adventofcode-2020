class Day1 < Base
  def part1
    find_sums(2020).inject(:*)
  end

  def find_sums(target)
    input_to_ints.combination(2) do |a, b|
      return [a, b] if a + b == target
    end
    nil
  end
end
