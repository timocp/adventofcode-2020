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
end
