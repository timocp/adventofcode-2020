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

  def test_part2
    d14 = Day14.new(<<~TEST)
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
    TEST
    assert_equal 208, d14.part2
    assert_equal 1, d14.mem(16)
    assert_equal 1, d14.mem(17)
    assert_equal 1, d14.mem(18)
    assert_equal 1, d14.mem(19)
    assert_equal 1, d14.mem(24)
    assert_equal 1, d14.mem(25)
    assert_equal 1, d14.mem(26)
    assert_equal 1, d14.mem(27)
    assert_equal 100, d14.mem(58)
    assert_equal 100, d14.mem(59)
  end
end
