require "day5"

class Day5Test < Minitest::Test
  def test_parse
    Day5.new.parse("FBFBBFFRLR").tap do |seat|
      assert_equal 44, seat.row
      assert_equal 5, seat.column
      assert_equal 357, seat.id
    end
    Day5.new.parse("BFFFBBFRRR").tap do |seat|
      assert_equal 70, seat.row
      assert_equal 7, seat.column
      assert_equal 567, seat.id
    end
    Day5.new.parse("FFFBBBFRRR").tap do |seat|
      assert_equal 14, seat.row
      assert_equal 7, seat.column
      assert_equal 119, seat.id
    end
    Day5.new.parse("BBFFBBFRLL").tap do |seat|
      assert_equal 102, seat.row
      assert_equal 4, seat.column
      assert_equal 820, seat.id
    end
  end
end
