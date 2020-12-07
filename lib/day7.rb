class Day7 < Base
  def part1
    rules.keys.count do |bag|
      may_contain?(bag, "shiny gold")
    end
  end

  def part2
    count_bags("shiny gold")
  end

  # Rules are hash keyed by bag (string), values are [other_bag, count]
  def rules
    @rules ||= parse_rules
  end

  def may_contain?(bag, search_bag)
    rules[bag].detect do |(other_bag, _count)|
      other_bag == search_bag || may_contain?(other_bag, search_bag)
    end
  end

  def count_bags(bag)
    rules[bag].map do |(other_bag, count)|
      count + count * count_bags(other_bag)
    end.sum
  end

  def parse_rules
    raw_input.each_line.with_object({}) do |line, rules|
      raise "Invalid input1: #{line.inspect}" unless (match = line.match(/^(.*) bags contain (.*)\.$/))
      rules[match[1]] = match[2].split(", ").reject { |rule| rule == "no other bags" }.map do |rule|
        raise "Invalid input2: #{rule.inspect} from #{line.inspect}" unless (match2 = rule.match(/^(\d+) (.*) bags?$/))
        [match2[2], match2[1].to_i]
      end
    end
  end
end
