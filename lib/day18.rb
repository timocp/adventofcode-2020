class Day18 < Base
  def part1
    raw_input.each_line.map { |line| evaluate(line.chomp) }.sum
  end

  def part2
    @advanced = true # means addition is evaluated BEFORE multiplication
    raw_input.each_line.map { |line| evaluate(line.chomp) }.sum
  end

  attr_accessor :advanced

  def evaluate(expr)
    parse(scan(expr)) # .tap { |a| warn "#{expr} -> #{a}" if advanced }
  end

  # parses an array of tokens; returns an integer result
  def parse(tokens)
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
      raise ArgumentError, "unmatched parens at: #{tokens.inspect}" if rgroup.nil?

      if lgroup.zero?
        parse([parse(tokens[(lgroup + 1)..(rgroup - 1)])] + tokens[(rgroup + 1)..])
      else
        parse(tokens[0..(lgroup - 1)] + [parse(tokens[(lgroup + 1)..(rgroup - 1)])] + tokens[(rgroup + 1)..])
      end
    elsif advanced && (plus = tokens.index("+"))
      # part 2 treats addition as high priority that multiplication
      if plus == 1
        parse([tokens[0] + tokens[2]] + tokens[3..])
      else
        parse(tokens[0, plus - 1] + [tokens[plus - 1] + tokens[plus + 1]] + tokens[(plus + 2)..])
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
  def scan(expr)
    s = StringScanner.new(expr)
    tokens = []
    until s.eos?
      s.skip(/\s+/)
      if (num = s.scan(/\d+/))
        tokens << num.to_i
      elsif (op = s.scan(/[+*()]/))
        tokens << op
      else
        raise ArgumentError, "scanner error at #{s.inspect}"
      end
    end
    tokens
  end
end
