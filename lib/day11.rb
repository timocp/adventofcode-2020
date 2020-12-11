class Day11 < Base
  def part1
    reset
    @crowded = 4
    build_visibility_map(deep: false)
    run
    to_s.count("#")
  end

  # 2211 is too high
  def part2
    reset
    @crowded = 5
    build_visibility_map(deep: true)
    run
    to_s.count("#")
  end

  attr_accessor :crowded, :visibility_map

  DIRECTIONS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  # perform one iteration.  "next" grid is populated in place, then becomes
  # the current grid.
  # If there were changes, returns true.  if there were no changes, returns
  # false
  def step
    changed = false
    grid[0].each_with_index do |row, r|
      row.each_with_index do |cell, c|
        if cell == "L"
          if occupied_visible_seats(r, c) == 0
            grid[1][r][c] = "#"
            changed = true
          else
            grid[1][r][c] = "L"
          end
        elsif cell == "#"
          if occupied_visible_seats(r, c) >= crowded
            grid[1][r][c] = "L"
            changed = true
          else
            grid[1][r][c] = "#"
          end
        end
      end
    end
    grid.reverse!
    changed
  end

  def occupied_visible_seats(r, c)
    visibility_map[r][c].count { |r2, c2| grid.dig(0, r2, c2) == "#" }
  end

  # step until chaos stabilizes
  def run
    loop while step
  end

  # print the current grid
  def to_s
    grid[0].map(&:join).join("\n") + "\n"
  end

  # for each [row, col], work out the coords of the visible seat in
  # each direction.  no need to retain ordering, so just drop directions that
  # no visible seat is in
  def build_visibility_map(deep:)
    @visibility_map =
      grid[0].map.with_index do |row, r|
        row.map.with_index do |_cell, c|
          DIRECTIONS.map do |dr, dc|
            found = [r, c]
            loop do
              found[0] += dr
              found[1] += dc
              if found[0] < 0 || found[0] >= grid[0].size ||
                 found[1] < 0 || found[1] >= grid[0].first.size
                found = nil
                break
              elsif grid[0][found[0]][found[1]] != "."
                break
              end
              break if !deep
            end
            found
          end.compact
        end
      end
  end

  # a grid is an array of arrays (matches input)
  # we setup a pair for updating state; the first one is "current".
  def grid
    @grid ||= [parse_grid, parse_grid]
  end

  def parse_grid
    raw_input.split("\n").map { |row| row.split("") }
  end

  def reset
    @grid = nil
  end
end
