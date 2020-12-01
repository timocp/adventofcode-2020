require "day1"

class Day1Test < Minitest::Test
  def test_part1
    d1 = Day1.new
    d1.test_input <<~END
      1721
      979
      366
      299
      675
      1456
    END
    assert_equal [1721, 299], d1.find_sums(2020)
    assert_equal 514579, d1.part1
  end
end
