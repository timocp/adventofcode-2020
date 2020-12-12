class Day12 < Base
  def part1
    @ship = Ship.new(0, 0, 0)
    move
    @ship.manhattan
  end

  def part2
    @ship = Ship.new(0, 0, 0, 10, -1)
    move_with_waypoint
    @ship.manhattan
  end

  attr_reader :ship

  # facing: 0 = E, 1 = S, 2 = W, 3 = N
  Ship = Struct.new(:facing, :x, :y, :wayx, :wayy) do
    def manhattan
      x.abs + y.abs
    end

    def north(num)
      self.y -= num
    end

    def east(num)
      self.x += num
    end

    def south(num)
      self.y += num
    end

    def west(num)
      self.x -= num
    end

    def left(degrees)
      self.facing = (facing - degrees / 90) % 4
    end

    def right(degrees)
      self.facing = (facing + degrees / 90) % 4
    end

    def forward(num)
      case facing
      when 0 then east(num)
      when 1 then south(num)
      when 2 then west(num)
      when 3 then north(num)
      end
    end

    def waypoint_north(num)
      self.wayy -= num
    end

    def waypoint_east(num)
      self.wayx += num
    end

    def waypoint_south(num)
      self.wayy += num
    end

    def waypoint_west(num)
      self.wayx -= num
    end

    def rotate_waypoint_left(degrees)
      rotate_waypoint_right(360 - degrees)
    end

    def rotate_waypoint_right(degrees)
      (degrees / 90).times { self.wayx, self.wayy = self.wayy * -1, self.wayx }
    end

    def move_to_waypoint(num)
      self.x += num * wayx
      self.y += num * wayy
    end
  end

  def move
    raw_input.each_line.map { |line| [line[0], line[1..].to_i] }.each do |command, num|
      case command
      when "N" then ship.north(num)
      when "S" then ship.south(num)
      when "E" then ship.east(num)
      when "W" then ship.west(num)
      when "L" then ship.left(num)
      when "R" then ship.right(num)
      when "F" then ship.forward(num)
      end
    end
  end

  def move_with_waypoint
    raw_input.each_line.map { |line| [line[0], line[1..].to_i] }.each do |command, num|
      case command
      when "N" then ship.waypoint_north(num)
      when "S" then ship.waypoint_south(num)
      when "E" then ship.waypoint_east(num)
      when "W" then ship.waypoint_west(num)
      when "L" then ship.rotate_waypoint_left(num)
      when "R" then ship.rotate_waypoint_right(num)
      when "F" then ship.move_to_waypoint(num)
      end
    end
  end
end
