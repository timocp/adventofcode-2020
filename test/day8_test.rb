require "day8"

class Day8Test < Minitest::Test
  TEST_INPUT = <<~END
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
  END

  def test_part1
    assert_equal 5, Day8.new(TEST_INPUT).part1
  end
end
