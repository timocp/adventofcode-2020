class Day7 < Base
  def part1
    rules.keys.count do |bag|
      may_contain?(bag, "shiny gold")
    end
  end

  # Rules are hash keyed by bag (string), values are [other_bag, count]
  def rules
    @rules ||= parse_rules
  end

  def may_contain?(bag, other_bag)
    rules[bag]&.detect do |(content_bag, _count)|
      content_bag == other_bag || may_contain?(content_bag, other_bag)
    end
  end

  def parse_rules
    raw_input.each_line.with_object({}) do |line, rules|
      raise "Invalid input1: #{line.inspect}" unless (match = line.match(/^(.*) bags contain (.*)\.$/))
      rules[match[1]] = match[2].split(", ").map do |rule|
        if rule == "no other bags"
          []
        elsif (match2 = rule.match(/^(\d+) (.*) bags?$/))
          [match2[2], match2[1].to_i]
        else
          raise "Invalid input2: #{rule.inspect} from #{line.inspect}"
        end
      end
    end
  end
end
