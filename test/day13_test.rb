require "day13"

class Day13Test < Minitest::Test
  TEST_INPUT = <<~END
    939
    7,13,x,x,59,x,31,19
  END

  def test_part1
    d13 = Day13.new(TEST_INPUT)
    d13.parse
    assert_equal [59, 5], d13.earliest_bus
    assert_equal 59 * 5, d13.part1
  end

  def test_part2
    assert_equal 1068781, Day13.new(TEST_INPUT).part2
    assert_equal 3417, Day13.new("\n17,x,13,19\n").part2
    assert_equal 754018, Day13.new("\n67,7,59,61\n").part2
    assert_equal 779210, Day13.new("\n67,x,7,59,61\n").part2
    assert_equal 1261476, Day13.new("\n67,7,x,59,61\n").part2
    assert_equal 1202161486, Day13.new("\n1789,37,47,1889\n").part2
  end
end
