class Day3 < Base
  def part1
    count_trees(right: 3, down: 1)
  end

  def part2
    [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2]
    ].map do |right, down|
      count_trees(right: right, down: down)
    end.inject(:*)
  end

  def grid
    @grid ||= parse_grid
  end

  def width
    @width ||= grid[0].size
  end

  def at(row, col)
    grid.dig(row, col % width)
  end

  def count_trees(right:, down:)
    row = col = trees = 0
    while here = at(row, col)
      trees += 1 if here == TREE
      row += down
      col += right
    end
    trees
  end

  TREE = "#"
  OPEN = "."

  def parse_grid
    raw_input.each_line.map do |row|
      @width ||= row.chomp.length
      row.chomp.each_char.to_a
    end
  end
end
