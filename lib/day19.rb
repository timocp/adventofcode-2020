class Day19 < Base
  def part1
    parse
    @messages.count { |message| match?(message) }
  end

  def part2
    parse
    @raw[8] = "42 | 42 8"
    @raw[11] = "42 31 | 42 11 31"
    @messages.count { |message| match?(message) }
  end

  def match?(message)
    rule.match?(message)
  end

  def rule
    @rule ||= Regexp.new("^#{rule_to_regex(@raw[0], 0)}$")
  end

  def parse
    raw_rules, @messages = raw_input.split("\n\n").map { |input| input.split("\n") }
    @raw = raw_rules.map { |text| text.split(": ") }.to_h.transform_keys(&:to_i)
    @rule = nil
  end

  def rule_to_regex(rule, depth)
    if rule[0] == '"' && rule[2] == '"'
      rule[1]
    elsif rule.include?(" | ")
      left, right = rule.split(" | ")
      "(#{rule_to_regex(left, depth + 1)}|#{rule_to_regex(right, depth + 1)})"
    elsif depth > 25 # put a limit on the recursive rules
      "X"
    else
      rule.split(" ").map(&:to_i).map { |i| rule_to_regex(@raw[i], depth + 1) }.join
    end
  end
end
