require "day1"

class Day1Test < Minitest::Test
  TEST_INPUT = <<~END
    1721
    979
    366
    299
    675
    1456
  END

  def test_part1
    d1 = Day1.new(TEST_INPUT)
    assert_equal [1721, 299], d1.find_sums(2020, 2)
    assert_equal 514579, d1.part1
  end

  def test_part2
    d1 = Day1.new(TEST_INPUT)
    assert_equal [979, 366, 675], d1.find_sums(2020, 3)
    assert_equal 241861950, d1.part2
  end
end
