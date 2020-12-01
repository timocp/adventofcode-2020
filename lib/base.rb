class Base
  def load_input
    @raw_input = File.read("input/day#{number}.txt")
  end

  def test_input(input)
    @raw_input = input
  end

  def input_to_ints
    @input_to_ints ||= raw_input.split.map(&:to_i)
  end

  def number
    self.class.name.match(/\d+$/)[0]
  end

  attr_reader :raw_input
end
