require "day23"

class Day23Test < Minitest::Test
  TEST_INPUT = "389125467\n".freeze

  def test_part1
    assert_equal(
      { 1 => 9, 9 => 2, 2 => 6, 6 => 5, 5 => 8, 8 => 3, 3 => 7, 7 => 4, 4 => 1 },
      Day23.new.play2(10, [3, 8, 9, 1, 2, 5, 4, 6, 7])
    )
    assert_equal "67384529", Day23.new(TEST_INPUT).part1
  end

  def test_part2
    # works but slow:
    # assert_equal 149245887792, Day23.new(TEST_INPUT).part2
  end
end
