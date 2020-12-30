class Day20 < Base
  def part1
    corners.inject(&:*)
  end

  def part2
    [false, true].each do |hflip|
      [false, true].each do |vflip|
        [false, true].each do |transpose|
          img = image.map(&:dup)
          img = img.reverse if hflip
          img = img.map(&:reverse) if vflip
          img = img.transpose if transpose
          # puts "CHECKING #{hflip} #{vflip} #{transpose}"
          count = detect_sea_monsters!(img)
          next if count.zero?

          # puts "FOUND MONSTERS:"
          # puts img.map(&:join).join("\n")
          # puts
          return img.sum { |row| row.count("#") }
        end
      end
    end
    nil
  end

  def solve
    return if @solution

    # tiles where we know the correct placement
    # The key is location [x, y], and the value is a has of:
    #   tile: Tile object
    #   hflip, vflip, transpose: booleans indicating tile orientation
    #   edges: array of pre-calculated edge values
    @solution = {}

    # solution is based on tile[0] being placed at (0,0), in a horizontally
    # flipped configuration (this is arbitrary, but makes it match the example)
    unknown = tiles
    first = unknown.shift
    @solution[[0, 0]] = {
      tile: first,
      hflip: true, vflip: false, transpose: false,
      edges: [
        first.edge(NORTH, true, false, false),
        first.edge(EAST, true, false, false),
        first.edge(SOUTH, true, false, false),
        first.edge(WEST, true, false, false)
      ]
    }
    # warn "\nAdding tile #{first.number} at (0, 0)"

    # now loop trying to find tiles that will fit ANYWHERE on any existing
    # tile
    while unknown.any?
      index, x, y, hflip, vflip, transpose = find_matching_tile(unknown)
      tile = unknown.delete_at(index)
      # warn "Adding tile #{tile.number} at (#{x}, #{y}) (hflip=#{hflip}, vflip=#{vflip}, transpose=#{transpose})"
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
    solve
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
                 when NORTH then [0, 1]
                 when EAST then [-1, 0]
                 when SOUTH then [0, -1]
                 when WEST then [1, 0]
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

  # each tile stored as 10x10 2d array, with
  # - original tile number
  # - methods to access the edges (as a string), with or without flipping or
  #   transposing
  class Tile
    def initialize(input)
      @number = input.lines[0].match(/^Tile (\d+):/)[1].to_i
      @grid = input.lines[1..].map(&:chomp).map { |row| row.split("") }

      @edges = {}
    end

    attr_reader :number, :grid

    def real_edge(side)
      case side
      when NORTH then grid[0].join
      when EAST then grid.map { |row| row[-1] }.join
      when SOUTH then grid[-1].join
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

  def image
    @image ||= to_image
  end

  # takes the solution and places it in a 2d array of "#" and "."
  # the edges of the original tiles are not part of the image, so each tile
  # really makes up an 8x8 grid.
  def to_image
    solve
    offsetx = @solution.keys.map(&:first).min
    offsety = @solution.keys.map(&:last).min
    img = []
    @solution.each do |(tilex, tiley), soln|
      top = (tiley - offsety) * 8
      left = (tilex - offsetx) * 8
      grid = soln[:tile].grid[1..-2].map { |row| row[1..-2] } # chops edges
      grid = grid.reverse if soln[:hflip]
      grid = grid.map(&:reverse) if soln[:vflip]
      grid = grid.transpose if soln[:transpose]
      grid.each.with_index do |row, rownum|
        row.each.with_index do |cell, colnum|
          img[top + rownum] ||= []
          img[top + rownum][left + colnum] = cell
        end
      end
    end
    img
  end

  MONSTER = [
    "                  # ",
    "#    ##    ##    ###",
    " #  #  #  #  #  #   "
  ].freeze

  MONSTER_POINTS = MONSTER.each_with_index.map do |row, y|
    row.split("").each_with_index.select { |c, _x| c == "#" }.map { |_c, x| [x, y] }
  end.flatten.each_slice(2).to_a.freeze

  # returns the number of monsters found AND replaces "#" with "O" where they
  # were found in the image
  def detect_sea_monsters!(img)
    count = 0
    0.upto(img.size - MONSTER.size).each do |y|
      0.upto(img.first.size - MONSTER.first.size).each do |x|
        next unless MONSTER_POINTS.all? { |mx, my| img[y + my][x + mx] == "#" }

        MONSTER_POINTS.each { |mx, my| img[y + my][x + mx] = "O" }
        count += 1
      end
    end
    count
  end

  def tiles
    raw_input.split("\n\n").map { |tile| Tile.new(tile) }
  end
end
