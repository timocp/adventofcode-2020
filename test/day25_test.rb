require "day25"

class Day25Test < Minitest::Test
  def test_transform
    assert_equal 5764801, Day25.new.transform(subject: 7, loop_size: 8)
    assert_equal 17807724, Day25.new.transform(subject: 7, loop_size: 11)
  end

  def test_rev_transform
    assert_equal 8, Day25.new.rev_transform(subject: 7, value: 5764801)
    assert_equal 11, Day25.new.rev_transform(subject: 7, value: 17807724)
  end

  def test_enc_key
    assert_equal 14897079, Day25.new.transform(loop_size: 8, subject: 17807724)
    assert_equal 14897079, Day25.new.transform(loop_size: 11, subject: 5764801)
  end

  TEST_INPUT = "5764801\n17807724\n".freeze

  def test_part1
    assert_equal 14897079, Day25.new(TEST_INPUT).part1
  end
end
