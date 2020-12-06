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
end
