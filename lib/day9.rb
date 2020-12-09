class Day9 < Base
  def part1
    @preamble_size ||= 25
    first_invalid
  end

  attr_accessor :preamble_size

  # Returns the first number after the preamble which is NOT the sum of any
  # 2 numbers within the previous <preamble_size> numbers.
  def first_invalid
    input_to_ints.each_cons(preamble_size + 1).detect do |slice|
      !(slice[0, preamble_size].combination(2).detect { |pair| pair.sum == slice[-1] })
    end&.last
  end
end
