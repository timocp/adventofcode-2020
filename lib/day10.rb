class Day10 < Base
  def part1
    diffs = adapters.each_cons(2).map { |low, high| high - low }.tally
    diffs[1] * diffs[3]
  end

  def part2
    count_arrangements(0)
  end

  def count_arrangements(joltage)
    adapter_map[joltage][0] ||= [1, 2, 3].map { |n| adapter_map[joltage][n] ? count_arrangements(joltage + n) : 0 }.sum
  end

  def adapters
    @adapters ||= [0] + input_to_ints.sort + [input_to_ints.max + 3]
  end

  # Hash of arrays, key is joltage number
  # Array is: [
  #   <count of arrangements from here or nil if not known yet>,
  #   true if adapter for joltage + 1 exists,
  #   true if adapter for joltage + 2 exists,
  #   true if adapter for joltage + 3 exists
  # ]
  def adapter_map
    @adapter_map ||=
      adapters.map do |joltage|
        [joltage, [joltage == adapters.last ? 1 : nil] + [1, 2, 3].map { |n| adapters.include?(joltage + n) }]
      end.to_h
  end
end
