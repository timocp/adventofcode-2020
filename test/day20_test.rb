require "day20"

class Day20Test < Minitest::Test
  TEST_INPUT = <<~END
    Tile 2311:
    ..##.#..#.
    ##..#.....
    #...##..#.
    ####.#...#
    ##.##.###.
    ##...#.###
    .#.#.#..##
    ..#....#..
    ###...#.#.
    ..###..###

    Tile 1951:
    #.##...##.
    #.####...#
    .....#..##
    #...######
    .##.#....#
    .###.#####
    ###.##.##.
    .###....#.
    ..#.#..#.#
    #...##.#..

    Tile 1171:
    ####...##.
    #..##.#..#
    ##.#..#.#.
    .###.####.
    ..###.####
    .##....##.
    .#...####.
    #.##.####.
    ####..#...
    .....##...

    Tile 1427:
    ###.##.#..
    .#..#.##..
    .#.##.#..#
    #.#.#.##.#
    ....#...##
    ...##..##.
    ...#.#####
    .#.####.#.
    ..#..###.#
    ..##.#..#.

    Tile 1489:
    ##.#.#....
    ..##...#..
    .##..##...
    ..#...#...
    #####...#.
    #..#.#.#.#
    ...#.#.#..
    ##.#...##.
    ..##.##.##
    ###.##.#..

    Tile 2473:
    #....####.
    #..#.##...
    #.##..#...
    ######.#.#
    .#...#.#.#
    .#########
    .###.#..#.
    ########.#
    ##...##.#.
    ..###.#.#.

    Tile 2971:
    ..#.#....#
    #...###...
    #.#.###...
    ##.##..#..
    .#####..##
    .#..####.#
    #..#.#..#.
    ..####.###
    ..#.#.###.
    ...#.#.#.#

    Tile 2729:
    ...#.#.#.#
    ####.#....
    ..#.#.....
    ....#..#.#
    .##..##.#.
    .#.####...
    ####.#.#..
    ##.####...
    ##..#.##..
    #.##...##.

    Tile 3079:
    #.#.#####.
    .#..######
    ..#.......
    ######....
    ####.#..#.
    .#...#.##.
    #.#####.##
    ..#.###...
    ..#.......
    ..#.###...
  END

  def test_edge_str
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal "..##.#..#.", tile.edge_str(Day20::NORTH, false, false, false)
    assert_equal "...#.##..#", tile.edge_str(Day20::EAST, false, false, false)
    assert_equal "..###..###", tile.edge_str(Day20::SOUTH, false, false, false)
    assert_equal ".#####..#.", tile.edge_str(Day20::WEST, false, false, false)
  end

  def test_hflip
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal "..###..###", tile.edge_str(Day20::NORTH, true, false, false)
    assert_equal "#..##.#...", tile.edge_str(Day20::EAST, true, false, false)
    assert_equal "..##.#..#.", tile.edge_str(Day20::SOUTH, true, false, false)
    assert_equal ".#..#####.", tile.edge_str(Day20::WEST, true, false, false)
  end

  def test_vflip
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal ".#..#.##..", tile.edge_str(Day20::NORTH, false, true, false)
    assert_equal ".#####..#.", tile.edge_str(Day20::EAST, false, true, false)
    assert_equal "###..###..", tile.edge_str(Day20::SOUTH, false, true, false)
    assert_equal "...#.##..#", tile.edge_str(Day20::WEST, false, true, false)
  end

  def test_transpose
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal ".#####..#.", tile.edge_str(Day20::NORTH, false, false, true)
    assert_equal "..###..###", tile.edge_str(Day20::EAST, false, false, true)
    assert_equal "...#.##..#", tile.edge_str(Day20::SOUTH, false, false, true)
    assert_equal "..##.#..#.", tile.edge_str(Day20::WEST, false, false, true)
  end

  def test_both_flip
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal "###..###..", tile.edge_str(Day20::NORTH, true, true, false)
    assert_equal ".#..#####.", tile.edge_str(Day20::EAST, true, true, false)
    assert_equal ".#..#.##..", tile.edge_str(Day20::SOUTH, true, true, false)
    assert_equal "#..##.#...", tile.edge_str(Day20::WEST, true, true, false)
  end

  def test_hflip_and_transpose
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal ".#..#####.", tile.edge_str(Day20::NORTH, true, false, true)
    assert_equal "..##.#..#.", tile.edge_str(Day20::EAST, true, false, true)
    assert_equal "#..##.#...", tile.edge_str(Day20::SOUTH, true, false, true)
    assert_equal "..###..###", tile.edge_str(Day20::WEST, true, false, true)
  end

  def test_vflip_and_transpose
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal "...#.##..#", tile.edge_str(Day20::NORTH, false, true, true)
    assert_equal "###..###..", tile.edge_str(Day20::EAST, false, true, true)
    assert_equal ".#####..#.", tile.edge_str(Day20::SOUTH, false, true, true)
    assert_equal ".#..#.##..", tile.edge_str(Day20::WEST, false, true, true)
  end

  def test_both_flipped_and_transpose
    tile = Day20.new(TEST_INPUT).tiles[0]
    assert_equal "#..##.#...", tile.edge_str(Day20::NORTH, true, true, true)
    assert_equal ".#..#.##..", tile.edge_str(Day20::EAST, true, true, true)
    assert_equal ".#..#####.", tile.edge_str(Day20::SOUTH, true, true, true)
    assert_equal "###..###..", tile.edge_str(Day20::WEST, true, true, true)
  end

  def test_part1
    d20 = Day20.new(TEST_INPUT)
    d20.solve
    # this layout is vertically flipped from example because my solution always
    # retains original orientation of the first tile
    assert_equal [
      [3079, 2311, 1951],
      [2473, 1427, 2729],
      [1171, 1489, 2971]
    ], d20.layout
    assert_equal 20899048083289, d20.part1
  end
end
