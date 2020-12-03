require "day3"

class Day3Test < Minitest::Test
  TEST_INPUT = <<~END
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
  END

  def test_part1
    d3 = Day3.new(TEST_INPUT)
    assert_equal ".", d3.at(0, 0)
    assert_equal "#", d3.at(0, 2)
    assert_equal 7, d3.count_trees(right: 3, down: 1)
    assert_equal 7, d3.part1
  end

  def test_part2
    d3 = Day3.new(TEST_INPUT)
    assert_equal 2, d3.count_trees(right: 1, down: 1)
    assert_equal 7, d3.count_trees(right: 3, down: 1)
    assert_equal 3, d3.count_trees(right: 5, down: 1)
    assert_equal 4, d3.count_trees(right: 7, down: 1)
    assert_equal 2, d3.count_trees(right: 1, down: 2)
    assert_equal 336, d3.part2
  end
end
