class Day23 < Base
  def part1
    circle = play2(100, parse)

    # clockwise starting after and not including the 1
    cup = 1
    out = []
    out << cup while (cup = circle[cup]) != 1
    out.join
  end

  def part2
    circle = parse
    circle += ((circle.max + 1)..1000000).to_a
    circle = play2(10000000, circle)
    circle[1] * circle[circle[1]]
  end

  # hash version to reduce reallocations
  def play2(count, circle)
    # build a hash keyed by cup, value is the cup that follows it
    max = circle.max
    current = circle.first
    circle = circle.map.with_index { |cup, i| [cup, circle[i + 1] || circle[0]] }.to_h

    count.times do |move|
      pickup = [circle[current]]
      pickup << circle[pickup.last]
      pickup << circle[pickup.last]
      circle[current] = circle[pickup.last]
      destination = (current - 1).downto(1).detect { |d| !pickup.include?(d) }
      destination ||= max.downto(current + 1).detect { |d| !pickup.include?(d) }
      follows = circle[destination]
      circle[destination] = pickup[0]
      circle[pickup[0]] = pickup[1]
      circle[pickup[1]] = pickup[2]
      circle[pickup[2]] = follows
      current = circle[current]
    end

    circle
  end

  def parse
    raw_input.chomp.split("").map(&:to_i)
  end
end
