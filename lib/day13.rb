class Day13 < Base
  def part1
    parse
    earliest_bus.inject(&:*)
  end

  def part2
    parse
    crt(*buses.each_with_index.select { |bus, _i| bus }.map { |bus, i| [bus, bus - i] }.transpose)
  end

  # https://brilliant.org/wiki/chinese-remainder-theorem/
  # https://rosettacode.org/wiki/Chinese_remainder_theorem
  def crt(primes, remainders)
    max = primes.inject(&:*)
    x = primes.zip(remainders).map do |n, a|
      _, s = euclid(n, max / n)
      a * s * max / n
    end.sum
    x % max
  end

  def euclid(m, n)
    if m % n == 0
      [0, 1]
    else
      rs = euclid(n % m, m)
      r = rs[1] - rs[0] * (n / m)
      s = rs[0]
      [r, s]
    end
  end

  def parse
    lines = raw_input.split("\n")
    @earliest_timestamp = lines[0].to_i
    @buses = lines[1].split(",").map { |bus| bus == "x" ? nil : bus.to_i }
  end

  attr_reader :earliest_timestamp, :buses

  # returns [bus_number, wait mins]
  def earliest_bus
    buses.compact.map { |bus| [bus, bus - (earliest_timestamp % bus)] }.min_by(&:last)
  end
end
