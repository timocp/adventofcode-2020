require "day14"

class Day14Test < Minitest::Test
  TEST_INPUT = <<~END
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
  END

  def test_part1
    d14 = Day14.new(TEST_INPUT)
    assert_equal 165, d14.part1
    assert_equal 101, d14.mem(7)
    assert_equal 64, d14.mem(8)
  end
end
