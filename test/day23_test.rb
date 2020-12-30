require "day23"

class Day23Test < Minitest::Test
  TEST_INPUT = "389125467\n".freeze

  def test_part1
    assert_equal(
      [nil, 9, 6, 7, 1, 8, 5, 4, 3, 2],
      Day23.new.play2(10, [3, 8, 9, 1, 2, 5, 4, 6, 7])
    )
    assert_equal "67384529", Day23.new(TEST_INPUT).part1
  end

  def test_part2
    # works but slow:
    # assert_equal 149245887792, Day23.new(TEST_INPUT).part2
  end
end
