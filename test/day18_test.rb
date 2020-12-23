require "day18"

class Day18Test < Minitest::Test
  def test_bad_math
    assert_equal 2, Day18.evaluate("2")
    assert_equal 3, Day18.evaluate("1 + 2")
    assert_equal 2, Day18.evaluate("1 * 2")
    assert_equal 3, Day18.evaluate("(1 + 2)")
    assert_equal 2, Day18.evaluate("(1 * 2)")
    assert_equal 71, Day18.evaluate("1 + 2 * 3 + 4 * 5 + 6")
    assert_equal 51, Day18.evaluate("1 + (2 * 3) + (4 * (5 + 6))")
    assert_equal 26, Day18.evaluate("2 * 3 + (4 * 5)")
    assert_equal 437, Day18.evaluate("5 + (8 * 3 + 9 + 3 * 4 * 3)")
    assert_equal 12240, Day18.evaluate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")
    assert_equal 13632, Day18.evaluate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")
  end
end
