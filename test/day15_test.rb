require "day15"

class Day15Test < Minitest::Test
  def test_part1
    assert_equal [0, 3, 6, 0, 3, 3, 1, 0, 4, 0], Day15.new("0,3,6").play.take(10)
    assert_equal 436, Day15.new("0,3,6").part1
    assert_equal 1, Day15.new("1,3,2").part1
    assert_equal 10, Day15.new("2,1,3").part1
    assert_equal 27, Day15.new("1,2,3").part1
    assert_equal 78, Day15.new("2,3,1").part1
    assert_equal 438, Day15.new("3,2,1").part1
    assert_equal 1836, Day15.new("3,1,2").part1
  end
end
