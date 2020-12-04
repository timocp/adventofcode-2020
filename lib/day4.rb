class Day4 < Base
  def part1
    passports.count(&:valid?)
  end

  def passports
    @passports ||= parse_passports
  end

  class Passport
    def initialize(fields)
      @fields = fields
    end

    def valid?
      missing = %w[byr iyr eyr hgt hcl ecl pid cid] - @fields.keys
      missing.none? || missing == ["cid"]
    end
  end

  def parse_passports
    raw_input.split("\n\n").map do |passport|
      Passport.new(passport.split.map { |field| field.split(":") }.to_h)
    end
  end
end
