class Day14 < Base
  def part1
    @mask0 = 0
    @mask1 = 0
    @mem = Hash.new(0)
    parse
    @mem.values.sum
  end

  def part2
    @mem = Hash.new(0)
    parse2
    @mem.values.sum
  end

  def mem(m)
    @mem[m]
  end

  def parse
    raw_input.each_line do |line|
      if (m = line.match(/^mask = ([X01]{36})$/))
        @mask0 = m[1].tr("X", "1").tr("01", "10").to_i(2)
        @mask1 = m[1].tr("X", "0").to_i(2)
      elsif (m = line.match(/^mem\[(\d+)\] = (\d+)$/))
        @mem[m[1].to_i] = (m[2].to_i | @mask1) & ~@mask0
      else
        raise "parse error: #{line.inspect}"
      end
    end
  end

  def parse2
    raw_input.each_line do |line|
      if (m = line.match(/^mask = ([X01]{36})$/))
        @mask1 = m[1].tr("X", "0").to_i(2) # this mask changes bits to ones
        @xbits = m[1].each_char.with_index.select { |c, _i| c == "X" }.map { |_c, i| 35 - i }
      elsif (m = line.match(/^mem\[(\d+)\] = (\d+)$/))
        (2**@xbits.size).times.each do |n|
          address = m[1].to_i | @mask1
          @xbits.each.with_index do |x, i|
            address = if n & 2**i > 0
                        address | (2**x) # forced to be 1 this iteration
                      else
                        address & ~(2**x) # forced to be 0 this iteration
                      end
          end
          @mem[address] = m[2].to_i
        end
      else
        raise "parse error: #{line.inspect}"
      end
    end
  end
end
