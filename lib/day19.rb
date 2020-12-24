class Day19 < Base
  def part1
    parse
    @messages.count { |message| match?(message) }
  end

  def match?(message)
    @rule.match?(message)
  end

  def parse
    raw_rules, @messages = raw_input.split("\n\n").map { |input| input.split("\n") }
    @raw = raw_rules.map { |text| text.split(": ") }.to_h.transform_keys(&:to_i)

    # store rule 0 as a regex
    @rule = Regexp.new("^#{rule_to_regex(@raw[0])}$")
  end

  def rule_to_regex(rule)
    if rule[0] == '"' && rule[2] == '"'
      rule[1]
    elsif rule.include?(" | ")
      left, right = rule.split(" | ")
      "(#{rule_to_regex(left)}|#{rule_to_regex(right)})"
    else
      rule.split(" ").map(&:to_i).map { |i| rule_to_regex(@raw[i]) }.join
    end
  end
end
