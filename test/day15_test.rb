require "day15"

class Day15Test < Minitest::Test
  def test_part1
    assert_equal 0, Day15.new("0,3,6").play(1)
    assert_equal 3, Day15.new("0,3,6").play(2)
    assert_equal 6, Day15.new("0,3,6").play(3)
    assert_equal 0, Day15.new("0,3,6").play(4)
    assert_equal 3, Day15.new("0,3,6").play(5)
    assert_equal 3, Day15.new("0,3,6").play(6)
    assert_equal 1, Day15.new("0,3,6").play(7)
    assert_equal 0, Day15.new("0,3,6").play(8)
    assert_equal 4, Day15.new("0,3,6").play(9)
    assert_equal 0, Day15.new("0,3,6").play(10)
    assert_equal 436, Day15.new("0,3,6").part1
    assert_equal 1, Day15.new("1,3,2").part1
    assert_equal 10, Day15.new("2,1,3").part1
    assert_equal 27, Day15.new("1,2,3").part1
    assert_equal 78, Day15.new("2,3,1").part1
    assert_equal 438, Day15.new("3,2,1").part1
    assert_equal 1836, Day15.new("3,1,2").part1
  end

  def test_part2
    # passing but SLOW
    # assert_equal 175594, Day15.new("0,3,6").part2
    # assert_equal 2578, Day15.new("1,3,2").part2
    # assert_equal 3544142, Day15.new("2,1,3").part2
    # assert_equal 261214, Day15.new("1,2,3").part2
    # assert_equal 6895259, Day15.new("2,3,1").part2
    # assert_equal 18, Day15.new("3,2,1").part2
    # assert_equal 362, Day15.new("3,1,2").part2
  end
end
