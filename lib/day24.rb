class Day24 < Base
  def part1
    starting_grid.values.count { |v| v }
  end

  def part2
    grid = starting_grid
    100.times do
      grid = next_grid(grid)
    end
    grid.values.count { |v| v }
  end

  # using hex grid of doubled coordinates
  # see: https://www.redblobgames.com/grids/hexagons/#coordinates-doubled
  # constraint is (x + y) % 2 == 0
  def starting_grid
    # hash of grid.  key is coord [x, y].  value is true (black) or false (white)
    grid = Hash.new(false)

    raw_input.each_line do |line|
      pos = [0, 0]
      directions(line.chomp).each do |dir|
        pos = move(pos, dir)
      end
      grid[pos] = !grid[pos]
    end

    grid
  end

  NEIGHBOURS = [
    [+1, -1],
    [+2, +0],
    [+1, +1],
    [-1, +1],
    [-2, +0],
    [-1, -1]
  ].freeze

  def next_grid(grid)
    new = Hash.new(false)
    minx, maxx = grid.keys.map(&:first).minmax
    miny, maxy = grid.keys.map(&:last).minmax
    (miny - 1).upto(maxy + 1).each do |y|
      x0 = minx - 1
      x0 -= (y + x0) % 2
      x1 = maxx + 1
      x1 += (y + x1) % 2
      (x0..x1).step(2).each do |x|
        neighbours = 0
        NEIGHBOURS.each do |dx, dy|
          neighbours += 1 if grid[[x + dx, y + dy]]
          break if neighbours > 2 # don't care about higher than 3
        end
        if grid[[x, y]]
          new[[x, y]] = true unless (neighbours == 0 || neighbours > 2)
        elsif !grid[[x, y]] && neighbours == 2
          new[[x, y]] = true
        end
      end
    end
    new
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
