class Day20 < Base
  def part1
    solve
    corners.inject(&:*)
  end

  def solve
    # tiles where we know the correct placement
    # The key is location [x, y], and the value is a has of:
    #   tile: Tile object
    #   hflip, vflip, transpose: booleans indicating tile orientation
    #   edges: array of pre-calculated edge values
    @solution = {}

    # solution is based on tile[0] being placed at (0,0), in its original
    # unrotated and unflipped configuration.
    unknown = tiles
    first = unknown.shift
    @solution[[0, 0]] = {
      tile: first,
      hflip: false, vflip: false, transpose: false,
      edges: [
        first.edge(NORTH, false, false, false),
        first.edge(EAST, false, false, false),
        first.edge(SOUTH, false, false, false),
        first.edge(WEST, false, false, false)
      ]
    }

    # now loop trying to find tiles that will fit ANYWHERE on any existing
    # tile
    while unknown.any?
      index, x, y, hflip, vflip, transpose = find_matching_tile(unknown)
      tile = unknown.delete_at(index)
      @solution[[x, y]] = {
        tile: tile,
        hflip: hflip, vflip: vflip, transpose: transpose,
        edges: [
          tile.edge(NORTH, hflip, vflip, transpose),
          tile.edge(EAST, hflip, vflip, transpose),
          tile.edge(SOUTH, hflip, vflip, transpose),
          tile.edge(WEST, hflip, vflip, transpose)
        ]
      }
    end
  end

  def layout
    xx = @solution.keys.map(&:first).minmax
    yy = @solution.keys.map(&:last).minmax
    result = []
    yy[0].upto(yy[1]).each do |y|
      result << []
      xx[0].upto(xx[1]).each do |x|
        result[-1] << @solution.dig([x, y], :tile)&.number
      end
    end
    result
  end

  def corners
    xx = @solution.keys.map(&:first).minmax
    yy = @solution.keys.map(&:last).minmax
    [
      @solution[[xx[0], yy[0]]],
      @solution[[xx[0], yy[1]]],
      @solution[[xx[1], yy[0]]],
      @solution[[xx[1], yy[1]]]
    ].map { |corner| corner[:tile].number }
  end

  # find any tile that matches an existing part of the solution.
  # returns [index, x, y, hflip, vflip, transposed]
  #
  # does the order of the loops matter? would the direction calculation be
  # best done on the outer loop?
  def find_matching_tile(unknown)
    @solution.each do |(x, y), soln|
      [NORTH, EAST, SOUTH, WEST].each do |direction|
        # skip if already something here
        dx, dy = case direction
                 when NORTH then [0, -1]
                 when EAST then [1, 0]
                 when SOUTH then [0, 1]
                 when WEST then [-1, 0]
                 end
        next if @solution.key?([x + dx, y + dy])

        # try each unplaced tile in each orientation to see if it could be
        # placed next to `soln`
        unknown.each.with_index do |tile, i|
          [false, true].each do |hflip|
            [false, true].each do |vflip|
              [false, true].each do |transpose|
                if tile.edge(direction, hflip, vflip, transpose) == soln[:edges][(direction + 2) % 4]
                  # match!
                  return [i, x + dx, y + dy, hflip, vflip, transpose]
                end
              end
            end
          end
        end
      end
    end
  end

  NORTH = 0
  EAST = 1
  SOUTH = 2
  WEST = 3

  # each tile stored as 10 line strings, with
  # - original tile number
  # - methods to access the edges (as a string), with or without flipping or
  #   rotating
  class Tile
    def initialize(input)
      @number = input.lines[0].match(/^Tile (\d+):/)[1].to_i
      @grid = input.lines[1..].map(&:chomp)

      @edges = {}
    end

    attr_reader :number, :grid

    def real_edge(side)
      case side
      when NORTH then grid[0]
      when EAST then grid.map { |row| row[-1] }.join
      when SOUTH then grid[-1]
      when WEST then grid.map { |row| row[0] }.join
      else
        raise ArgumentError, "Invalid side #{side}"
      end
    end

    # edge (as string) returned (left to right or top to bottom for matching)
    # side: 0=N, 1=E, 2=S, 3=W
    #
    # hflip/vlip: with tile flipped horizontally and/or vertically
    # transpose: true/false: swap x/y axis.
    # these 3 booleans is enough to get all 8 possible edge orientations
    #
    # this is a mess but my earlier attempts to define these more succinctly
    # weren't working
    def edge_str(side, hflip, vflip, transpose)
      case [hflip, vflip, transpose]
      when [false, false, false]  # unmodified tile
        real_edge(side)
      when [true, false, false]   # horizontal flip
        if [NORTH, SOUTH].include?(side)
          real_edge((side + 2) % 4)
        else
          real_edge(side).reverse
        end
      when [false, true, false]   # vertical flip
        if [NORTH, SOUTH].include?(side)
          real_edge(side).reverse
        else
          real_edge((side + 2) % 4)
        end
      when [false, false, true]   # transpose
        case side
        when NORTH then real_edge(WEST)
        when EAST then real_edge(SOUTH)
        when SOUTH then real_edge(EAST)
        when WEST then real_edge(NORTH)
        end
      when [true, true, false]    # flip both ways
        case side
        when NORTH then real_edge(SOUTH).reverse
        when EAST then real_edge(WEST).reverse
        when SOUTH then real_edge(NORTH).reverse
        when WEST then real_edge(EAST).reverse
        end
      when [true, false, true]    # horizontal flip and transpose
        case side
        when NORTH then real_edge(WEST).reverse
        when EAST then real_edge(NORTH)
        when SOUTH then real_edge(EAST).reverse
        when WEST then real_edge(SOUTH)
        end
      when [false, true, true]    # vertical flip and transpose
        case side
        when NORTH then real_edge(EAST)
        when EAST then real_edge(SOUTH).reverse
        when SOUTH then real_edge(WEST)
        when WEST then real_edge(NORTH).reverse
        end
      when [true, true, true]     # both flips and transpose
        case side
        when NORTH then real_edge(EAST).reverse
        when EAST then real_edge(NORTH).reverse
        when SOUTH then real_edge(WEST).reverse
        when WEST then real_edge(SOUTH).reverse
        end
      end
    end

    # edge (as an integer, treating the pattern as a bitmask)
    # result is memoized
    def edge(side, hflip, vflip, transpose)
      @edges[[side, hflip, vflip, transpose]] ||=
        begin
          edge_str(side, hflip, vflip, transpose).tr("#.", "10").to_i(2)
        end
    end
  end

  def tiles
    raw_input.split("\n\n").map { |tile| Tile.new(tile) }
  end
end
