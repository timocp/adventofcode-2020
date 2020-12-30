require "day21"

class Day21Test < Minitest::Test
  TEST_INPUT = <<~END
    mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)
  END

  def test_part1
    assert_equal 5, Day21.new(TEST_INPUT).part1
  end

  def test_part2
    assert_equal "mxmxvkd,sqjhc,fvjkl", Day21.new(TEST_INPUT).part2
  end
end
