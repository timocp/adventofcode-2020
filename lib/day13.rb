class Day13 < Base
  def part1
    parse
    earliest_bus.inject(&:*)
  end

  def parse
    lines = raw_input.split("\n")
    @earliest_timestamp = lines[0].to_i
    @buses = lines[1].split(",").reject { |bus| bus == "x" }.map(&:to_i)
  end

  attr_reader :earliest_timestamp, :buses

  # returns [bus_number, wait mins]
  def earliest_bus
    buses.map { |bus| [bus, bus - (earliest_timestamp % bus)] }.min_by(&:last)
  end
end
