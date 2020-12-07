require "day7"

class Day7Test < Minitest::Test
  TEST_INPUT = <<~END
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
  END

  def test_part1
    d7 = Day7.new(TEST_INPUT)
    assert d7.may_contain?("bright white", "shiny gold")
    assert d7.may_contain?("muted yellow", "shiny gold")
    assert d7.may_contain?("dark orange", "shiny gold")
    assert d7.may_contain?("light red", "shiny gold")
    refute d7.may_contain?("dark olive", "shiny gold")
    refute d7.may_contain?("vibrant plum", "shiny gold")
    refute d7.may_contain?("faded blue", "shiny gold")
    refute d7.may_contain?("dotted black", "shiny gold")
    assert_equal 4, Day7.new(TEST_INPUT).part1
  end

  TEST_INPUT2 = <<~END
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
  END

  def test_part2
    d7 = Day7.new(TEST_INPUT)
    assert_equal 0, d7.count_bags("faded blue")
    assert_equal 0, d7.count_bags("dotted black")
    assert_equal 11, d7.count_bags("vibrant plum")
    assert_equal 7, d7.count_bags("dark olive")
    assert_equal 32, d7.count_bags("shiny gold")
    assert_equal 126, Day7.new(TEST_INPUT2).count_bags("shiny gold")
  end
end
