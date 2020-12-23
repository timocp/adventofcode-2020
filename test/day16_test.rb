require "day16"

class Day16Test < Minitest::Test
  TEST_INPUT = <<~END
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
  END

  def test_parse
    d16 = Day16.new(TEST_INPUT)
    d16.parse
    assert_equal "class", d16.field(0).label
    [1, 2, 3, 5, 6, 7].each do |i|
      assert d16.field(0).valid?(i)
    end
    [0, 4, 8].each do |i|
      refute d16.field(0).valid?(i)
    end
    assert_equal [7, 1, 14], d16.my_ticket
    assert_equal [7, 3, 47], d16.nearby_ticket(0)
    assert_equal [4, 55, 12], d16.invalid_nearby_values
  end

  def test_part1
    assert_equal 71, Day16.new(TEST_INPUT).part1
  end

  def test_part2
    d16 = Day16.new(<<~END)
      class: 0-1 or 4-19
      row: 0-5 or 8-19
      seat: 0-13 or 16-19

      your ticket:
      11,12,13

      nearby tickets:
      3,9,18
      15,1,5
      5,14,9
    END
    d16.parse
    result = d16.identify_my_ticket
    assert_equal 12, result["class"]
    assert_equal 11, result["row"]
    assert_equal 13, result["seat"]
  end
end
