require "day6"

class Day6Test < Minitest::Test
  TEST_INPUT = <<~END
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
  END

  def test_part1
    assert_equal 11, Day6.new(TEST_INPUT).part1
  end

  def test_part2
    assert_equal 6, Day6.new(TEST_INPUT).part2
  end
end
