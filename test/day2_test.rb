require "day2"

class Day2Test < Minitest::Test
  TEST_INPUT = <<~END
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
  END

  def test_part1
    d2 = Day2.new(TEST_INPUT)
    assert_equal 1, d2.entries[0].min
    assert_equal 3, d2.entries[0].max
    assert_equal "a", d2.entries[0].letter
    assert_equal "abcde", d2.entries[0].password
    assert d2.entries[0].valid?
    refute d2.entries[1].valid?
    assert d2.entries[2].valid?
    assert_equal 2, d2.part1
  end

  def test_part2
    d2 = Day2.new(TEST_INPUT)
    assert d2.entries[0].valid2?
    refute d2.entries[1].valid2?
    refute d2.entries[2].valid2?
    assert_equal 1, d2.part2
  end
end
