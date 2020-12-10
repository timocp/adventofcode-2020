require "day9"

class Day9Test < Minitest::Test
  TEST_INPUT = <<~END
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
  END

  def test_part1
    d9 = Day9.new(TEST_INPUT)
    d9.preamble_size = 5
    assert_equal 127, d9.part1
  end

  def test_part2
    d9 = Day9.new(TEST_INPUT)
    d9.preamble_size = 5
    assert_equal [15, 25, 47, 40], d9.find_weakness
    assert_equal 62, d9.part2
  end
end
