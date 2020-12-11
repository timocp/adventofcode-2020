require "day11"

class Day11Test < Minitest::Test
  TEST_INPUT = <<~END
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
  END

  def test_part1
    d11 = Day11.new(TEST_INPUT)
    d11.crowded = 4
    d11.build_visibility_map(deep: false)
    assert_equal TEST_INPUT, d11.to_s
    d11.step
    assert_equal <<~END, d11.to_s
      #.##.##.##
      #######.##
      #.#.#..#..
      ####.##.##
      #.##.##.##
      #.#####.##
      ..#.#.....
      ##########
      #.######.#
      #.#####.##
    END
    d11.step
    assert_equal <<~END, d11.to_s
      #.LL.L#.##
      #LLLLLL.L#
      L.L.L..L..
      #LLL.LL.L#
      #.LL.LL.LL
      #.LLLL#.##
      ..L.L.....
      #LLLLLLLL#
      #.LLLLLL.L
      #.#LLLL.##
    END
    d11.run
    assert_equal 37, d11.to_s.count("#")
    assert_equal 37, d11.part1
  end

  def test_day2
    d11 = Day11.new(TEST_INPUT)
    assert_equal 26, d11.part2
  end
end
