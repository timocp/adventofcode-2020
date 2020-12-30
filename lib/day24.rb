class Day24 < Base
  # using hex grid of doubled coordinates
  # see: https://www.redblobgames.com/grids/hexagons/#coordinates-doubled
  # constraint is (x + y) % 2 == 0
  def part1
    # hash of grid.  key is coord [x, y].  value is true (black) or false (white)
    grid = Hash.new(false)

    raw_input.each_line do |line|
      pos = [0, 0]
      directions(line.chomp).each do |dir|
        pos = move(pos, dir)
      end
      grid[pos] = !grid[pos]
    end

    grid.values.count { |v| v }
  end

  def move(pos, dir)
    case dir
    when :ne then [pos.first + 1, pos.last - 1]
    when :e  then [pos.first + 2, pos.last]
    when :se then [pos.first + 1, pos.last + 1]
    when :sw then [pos.first - 1, pos.last + 1]
    when :w  then [pos.first - 2, pos.last]
    when :nw then [pos.first - 1, pos.last - 1]
    end
  end

  def directions(line)
    s = StringScanner.new(line)
    list = []
    until s.eos?
      if s.scan(/^e/)
        list << :e
      elsif s.scan(/^se/)
        list << :se
      elsif s.scan(/^sw/)
        list << :sw
      elsif s.scan(/^w/)
        list << :w
      elsif s.scan(/^nw/)
        list << :nw
      elsif s.scan(/^ne/)
        list << :ne
      else
        raise ArgumentError, "scanner error: #{s.inspect}"
      end
    end
    list
  end
end
