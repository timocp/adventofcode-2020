require "day10"

class Day10Test < Minitest::Test
  TEST_INPUT1 = <<~END
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
  END

  TEST_INPUT2 = <<~END
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
  END

  def test_part1
    assert_equal 7 * 5, Day10.new(TEST_INPUT1).part1
    assert_equal 22 * 10, Day10.new(TEST_INPUT2).part1
  end
end
