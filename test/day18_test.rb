require "day18"

class Day18Test < Minitest::Test
  def test_bad_math
    d18 = Day18.new
    assert_equal 2, d18.evaluate("2")
    assert_equal 3, d18.evaluate("1 + 2")
    assert_equal 2, d18.evaluate("1 * 2")
    assert_equal 3, d18.evaluate("(1 + 2)")
    assert_equal 2, d18.evaluate("(1 * 2)")
    assert_equal 71, d18.evaluate("1 + 2 * 3 + 4 * 5 + 6")
    assert_equal 51, d18.evaluate("1 + (2 * 3) + (4 * (5 + 6))")
    assert_equal 26, d18.evaluate("2 * 3 + (4 * 5)")
    assert_equal 437, d18.evaluate("5 + (8 * 3 + 9 + 3 * 4 * 3)")
    assert_equal 12240, d18.evaluate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")
    assert_equal 13632, d18.evaluate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")
  end

  def test_bad_advanced_math
    d18 = Day18.new
    d18.advanced = true
    assert_equal 231, d18.evaluate("1 + 2 * 3 + 4 * 5 + 6")
    assert_equal 51, d18.evaluate("1 + (2 * 3) + (4 * (5 + 6))")
    assert_equal 46, d18.evaluate("2 * 3 + (4 * 5)")
    assert_equal 1445, d18.evaluate("5 + (8 * 3 + 9 + 3 * 4 * 3)")
    assert_equal 669060, d18.evaluate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")
    assert_equal 23340, d18.evaluate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")
  end
end
