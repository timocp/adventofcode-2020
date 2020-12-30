class Day23 < Base
  def part1
    play(100)
  end

  def play(count)
    circle = parse

    # circle is an array; keep the "current" cup at index 0 (this simplifies
    # pickups and moves)
    count.times do |move|
      pickup = circle.slice(1, 3)
      destination = (circle[0] - 1).downto(1).detect { |d| !pickup.include?(d) }
      destination ||= 9.downto(circle[0] + 1).detect { |d| !pickup.include?(d) }
      dpos = circle.index(destination)
      circle = circle[4..dpos] + pickup + circle[(dpos + 1)..9] + [circle[0]]
    end

    # clockwise starting after and not including the 1
    one = circle.index(1)
    if one.zero?
      circle[(one + 1)..].join
    else
      (circle[(one + 1)..] + circle[..(one - 1)]).join
    end
  end

  def parse
    raw_input.chomp.split("").map(&:to_i)
  end
end
