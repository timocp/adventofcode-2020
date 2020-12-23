class Day18 < Base
  def part1
    raw_input.each_line.map { |line| evaluate(line.chomp) }.sum
  end

  def evaluate(expr)
    self.class.evaluate(expr)
  end

  def self.evaluate(expr)
    parse(scan(expr)) # .tap { |a| warn "#{expr} -> #{a}" }
  end

  def self.parse(tokens)
    if tokens.size == 1
      tokens.first
    elsif (lgroup = tokens.index("("))
      # replace any groupings first
      depth = 0
      rgroup = nil
      tokens[lgroup..].each.with_index(lgroup) do |token, i|
        if token == "("
          depth += 1
        elsif token == ")"
          depth -= 1
          if depth.zero?
            rgroup = i
            break
          end
        end
      end
      raise ArgumentError, "unmatched paraens at: #{tokens.inspect}" if rgroup.nil?
      if lgroup.zero?
        parse([parse(tokens[(lgroup + 1)..(rgroup - 1)])] + tokens[(rgroup + 1)..])
      else
        parse(tokens[0..(lgroup - 1)] + [parse(tokens[(lgroup + 1)..(rgroup - 1)])] + tokens[(rgroup + 1)..])
      end
    elsif tokens[1] == "+"
      parse([tokens[0] + tokens[2]] + tokens[3..])
    elsif tokens[1] == "*"
      parse([tokens[0] * tokens[2]] + tokens[3..])
    else
      raise ArgumentError, "parser error at: #{tokens.inspect}"
    end
  end

  # lexical scanner, turn string into array of components
  def self.scan(expr)
    s = StringScanner.new(expr)
    tokens = []
    until s.eos?
      s.skip(/\s+/)
      if (num = s.scan(/\d+/))
        tokens << num.to_i
      elsif (op = s.scan(/[+*()]/))
        tokens << op
      else
        binding.pry
        raise ArgumentError, "scanner error at #{s.inspect}"
      end
    end
    tokens
  end
end
