require "day12"

class Day12Test < Minitest::Test
  TEST_INPUT = <<~END
    F10
    N3
    F7
    R90
    F11
  END

  def test_part1
    d12 = Day12.new(TEST_INPUT)
    assert_equal 25, d12.part1
    assert_equal 17, d12.ship.x
    assert_equal 8, d12.ship.y
  end
end
