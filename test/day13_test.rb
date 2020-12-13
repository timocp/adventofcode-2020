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
end
