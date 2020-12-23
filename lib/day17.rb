require "set"

class Day17 < Base
  def part1
    grid = parse
    6.times { grid.iterate }
    grid.population
  end

  def part2
    grid = parse
    grid.hyper!
    6.times { grid.iterate }
    grid.population
  end

  Point = Struct.new(:x, :y, :z, :w)

  # a grid is a Set of Points which are active
  class Grid
    def initialize
      @grid = Set.new
    end

    # adds a 4th dimension (w)
    def hyper!
      @hyper = true
    end

    def set(x, y, z, w)
      @grid.add(Point.new(x, y, z, w))
    end

    def active?(x, y, z, w)
      @grid.include?(Point.new(x, y, z, w))
    end

    def population
      @grid.size
    end

    # replaces grid with a new one after 1 iteration
    def iterate
      new_grid = Set.new
      range(:w, true).each do |w|
        range(:z, true).each do |z|
          range(:y, true).each do |y|
            range(:x, true).each do |x|
              if active?(x, y, z, w)
                # next cube is active if there are 2-3 active neighbours
                new_grid.add(Point.new(x, y, z, w)) if [2, 3].include?(active_neighbours(x, y, z, w, stop: 4))
              else
                # next cube is active if exactly 3 active neighbours
                new_grid.add(Point.new(x, y, z, w)) if active_neighbours(x, y, z, w, stop: 4) == 3
              end
            end
          end
        end
      end
      @grid = new_grid # replace with next one
    end

    # count active neighbours next to this cube (up to stop)
    def active_neighbours(x, y, z, w, stop: nil)
      count = 0
      wrange = @hyper ? [-1, 0, 1] : [0]
      wrange.each do |dw|
        [-1, 0, 1].each do |dz|
          [-1, 0, 1].each do |dy|
            [-1, 0, 1].each do |dx|
              next if dz.zero? && dy.zero? && dx.zero? && dw.zero?
              next unless active?(x + dx, y + dy, z + dz, w + dw)

              count += 1
              return count if stop && count == stop
            end
          end
        end
      end
      count
    end

    def to_s
      s = ""
      range(:w).each do |w|
        range(:z).each do |z|
          s += "z=#{z}, w=#{w}\n"
          range(:y).each do |y|
            range(:x).each do |x|
              s += active?(x, y, z, w) ? "#" : "."
            end
            s += "\n"
          end
          s += "\n"
        end
        s += "\n"
      end
      "#{s}\n"
    end

    def range(axis, expand = false)
      return 0..0 if !@hyper && axis == :w

      min, max = @grid.map(&axis).minmax
      if expand
        min -= 1
        max += 1
      end
      min..max
    end
  end

  def parse
    grid = Grid.new
    raw_input.each_line.with_index do |line, y|
      line.each_char.with_index do |c, x|
        grid.set(x, y, 0, 0) if c == "#"
      end
    end
    grid
  end
end
