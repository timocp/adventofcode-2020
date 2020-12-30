require "day23"

class Day23Test < Minitest::Test
  TEST_INPUT = "389125467\n".freeze

  def test_part1
    assert_equal "92658374", Day23.new(TEST_INPUT).play(10)
    assert_equal "67384529", Day23.new(TEST_INPUT).play(100)
    assert_equal "67384529", Day23.new(TEST_INPUT).part1
  end
end
