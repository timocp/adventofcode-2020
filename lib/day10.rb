class Day10 < Base
  def part1
    diffs = adapters.each_cons(2).map { |low, high| high - low }.tally
    diffs[1] * diffs[3]
  end

  def adapters
    @adapters ||= [0] + input_to_ints.sort + [input_to_ints.max + 3]
  end
end
