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
    assert_equal [
      [1951, 2311, 3079],
      [2729, 1427, 2473],
      [2971, 1489, 1171]
    ], d20.layout
    assert_equal 20899048083289, d20.part1
  end

  TEST_IMAGE = <<~END
    .#.#..#.##...#.##..#####
    ###....#.#....#..#......
    ##.##.###.#.#..######...
    ###.#####...#.#####.#..#
    ##.#....#.##.####...#.##
    ...########.#....#####.#
    ....#..#...##..#.#.###..
    .####...#..#.....#......
    #..#.##..#..###.#.##....
    #.####..#.####.#.#.###..
    ###.#.#...#.######.#..##
    #.####....##..########.#
    ##..##.#...#...#.#.#.#..
    ...#..#..#.#.##..###.###
    .#.#....#.##.#...###.##.
    ###.#...#..#.##.######..
    .#.#.###.##.##.#..#.##..
    .####.###.#...###.#..#.#
    ..#.#..#..#.#.#.####.###
    #..####...#.#.#.###.###.
    #####..#####...###....##
    #.##..#..#...#..####...#
    .#.###..##..##..####.##.
    ...###...##...#...#..###
  END

  def test_to_image
    d20 = Day20.new(TEST_INPUT)
    assert_equal(TEST_IMAGE, d20.to_image.map(&:join).map { |row| "#{row}\n" }.join)
  end

  TEST_MONSTER = <<~END
    .####...#####..#...###..
    #####..#..#.#.####..#.#.
    .#.#...#.###...#.##.O#..
    #.O.##.OO#.#.OO.##.OOO##
    ..#O.#O#.O##O..O.#O##.##
    ...#.#..##.##...#..#..##
    #.##.#..#.#..#..##.#.#..
    .###.##.....#...###.#...
    #.####.#.#....##.#..#.#.
    ##...#..#....#..#...####
    ..#.##...###..#.#####..#
    ....#.##.#.#####....#...
    ..##.##.###.....#.##..#.
    #...#...###..####....##.
    .#.##...#.##.#.#.###...#
    #.###.#..####...##..#...
    #.###...#.##...#.##O###.
    .O##.#OO.###OO##..OOO##.
    ..O#.O..O..O.#O##O##.###
    #.#..##.########..#..##.
    #.#####..#.#...##..#....
    #....##..#.#########..##
    #...#.....#..##...###.##
    #..###....##.#...##.##.#
  END

  def test_detect_sea_monster
    d20 = Day20.new(TEST_INPUT)
    img = d20.image
    # none in the original image
    assert_equal 0, d20.detect_sea_monsters!(img)

    # 2 if the example is transposed
    img = img.transpose
    assert_equal 2, d20.detect_sea_monsters!(img)
    assert_equal(TEST_MONSTER, img.map(&:join).map { |row| "#{row}\n" }.join)
  end

  def test_part2
    assert_equal 273, Day20.new(TEST_INPUT).part2
  end
end
