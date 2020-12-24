require "set"

class Day17 < Base
  def part1
    grid = parse(hyper: false)
    6.times { grid = grid.next }
    grid.population
  end

  def part2
    grid = parse(hyper: true)
    6.times { grid = grid.next }
    grid.population
  end

  # a grid is a Set of Points which are active
  class Grid
    def initialize(hyper)
      @grid = Set.new
      @hyper = hyper
      @minx = @maxx = @miny = @maxy = @minz = @maxz = @minw = @maxw = 0
    end

    attr_reader :minx, :maxx, :miny, :maxy, :minz, :maxz, :minw, :maxw

    def set(x, y, z, w)
      @grid.add([x, y, z, w])
      @minx = x if x < @minx
      @maxx = x if x > @maxx
      @miny = y if y < @miny
      @maxy = y if y > @maxy
      @minz = z if z < @minz
      @maxz = z if z > @maxz
      return unless @hyper

      @minw = w if w < @minw
      @maxw = w if w > @maxw
    end

    def active?(x, y, z, w)
      @grid.include?([x, y, z, w])
    end

    def population
      @grid.size
    end

    # returns a new grid after simulating 1 iteration
    def next
      new_grid = Grid.new(@hyper)
      (@hyper ? (minw - 1).upto(maxw + 1) : [0]).each do |w|
        (minz - 1).upto(maxz + 1).each do |z|
          (miny - 1).upto(maxy + 1).each do |y|
            (minx - 1).upto(maxx + 1).each do |x|
              neighbours = active_neighbours(x, y, z, w)
              if active?(x, y, z, w) && [2, 3].include?(neighbours)
                # active and 2-3 active neighbours
                new_grid.set(x, y, z, w)
              elsif !active?(x, y, z, w) && neighbours == 3
                # inactive and exactly 3 neighbours
                new_grid.set(x, y, z, w) if active_neighbours(x, y, z, w) == 3
              end
            end
          end
        end
      end
      new_grid
    end

    # count active neighbours next to this cube (up to 4)
    def active_neighbours(x, y, z, w)
      count = 0
      (@hyper ? [-1, 0, 1] : [0]).each do |dw|
        [-1, 0, 1].each do |dz|
          [-1, 0, 1].each do |dy|
            [-1, 0, 1].each do |dx|
              next if dz.zero? && dy.zero? && dx.zero? && dw.zero?
              next unless active?(x + dx, y + dy, z + dz, w + dw)

              count += 1
              return count if count == 4 # don't care about counts higher than 4
            end
          end
        end
      end
      count
    end

    def to_s
      s = ""
      minw.upto(maxw).each do |w|
        minz.upto(maxz).each do |z|
          s += "z=#{z}, w=#{w}\n"
          miny.upto(maxy).each do |y|
            minx.upto(maxx).each do |x|
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
  end

  def parse(hyper:)
    grid = Grid.new(hyper)
    raw_input.each_line.with_index do |line, y|
      line.each_char.with_index do |c, x|
        grid.set(x, y, 0, 0) if c == "#"
      end
    end
    grid
  end
end
