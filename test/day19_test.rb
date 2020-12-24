require "day19"

class Day19Test < Minitest::Test
  TEST_INPUT = <<~END
    0: 4 1 5
    1: 2 3 | 3 2
    2: 4 4 | 5 5
    3: 4 5 | 5 4
    4: "a"
    5: "b"

    ababbb
    bababa
    abbbab
    aaabbb
    aaaabbb
  END

  def test_match
    d19 = Day19.new(TEST_INPUT)
    d19.parse
    assert d19.match?("ababbb")
    refute d19.match?("bababa")
    assert d19.match?("ababbb")
    refute d19.match?("bababa")
    assert d19.match?("abbbab")
    refute d19.match?("aaabbb")
    refute d19.match?("aaaabbb")
  end

  def test_part1
    assert_equal 2, Day19.new(TEST_INPUT).part1
  end
end
