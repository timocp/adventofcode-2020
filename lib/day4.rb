class Day4 < Base
  def part1
    passports.count(&:valid?)
  end

  def part2
    passports.count(&:strict_valid?)
  end

  def passports
    @passports ||= parse_passports
  end

  class Passport
    def initialize(fields)
      @fields = fields
    end

    attr_reader :fields

    def valid?
      missing = %w[byr iyr eyr hgt hcl ecl pid cid] - fields.keys
      missing.none? || missing == ["cid"]
    end

    def strict_valid?
      valid? &&
        fields["byr"].between?("1920", "2002") &&
        fields["iyr"].between?("2010", "2020") &&
        fields["eyr"].between?("2020", "2030") &&
        valid_height? &&
        fields["hcl"].match?(/^#\h{6}$/) &&
        %w[amb blu brn gry grn hzl oth].include?(fields["ecl"]) &&
        fields["pid"].match?(/^\d{9}$/)
    end

    def valid_height?
      (fields["hgt"].end_with?("cm") && fields["hgt"].to_i.between?(150, 193)) ||
        (fields["hgt"].end_with?("in") && fields["hgt"].to_i.between?(59, 76))
    end
  end

  def parse_passports
    raw_input.split("\n\n").map do |passport|
      Passport.new(passport.split.map { |field| field.split(":") }.to_h)
    end
  end
end
