class Day14 < Base
  def part1
    @mask0 = 0
    @mask1 = 0
    @mem = Hash.new(0)
    parse
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
end
