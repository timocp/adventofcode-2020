require "day17"

class Day17Test < Minitest::Test
  TEST_INPUT = <<~END
    .#.
    ..#
    ###
  END

  def test_part1
    assert_equal 112, Day17.new(TEST_INPUT).part1
  end
end
