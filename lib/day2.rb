class Day2 < Base
  def part1
    entries.count(&:valid?)
  end

  def part2
    entries.count(&:valid2?)
  end

  Entry = Struct.new(:min, :max, :letter, :password) do
    # sled rental policy
    def valid?
      password.count(letter).between?(min, max)
    end

    # toboggan policy
    def valid2?
      (password[min - 1] == letter) ^ (password[max - 1] == letter)
    end
  end

  def entries
    @entries ||= raw_input.each_line.map do |line|
      line.match(/^(\d+)-(\d+) ([a-z]): ([a-z]+)$/) do |m|
        Entry.new(m[1].to_i, m[2].to_i, m[3], m[4])
      end
    end
  end
end
