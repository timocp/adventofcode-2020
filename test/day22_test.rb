require "day22"

class Day22Test < Minitest::Test
  TEST_INPUT = <<~END
    Player 1:
    9
    2
    6
    3
    1

    Player 2:
    5
    8
    4
    7
    10
  END

  def test_part1
    assert_equal 306, Day22.new(TEST_INPUT).part1
  end
end
