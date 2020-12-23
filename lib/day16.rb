require "set"

class Day16 < Base
  def part1
    parse
    invalid_nearby_values.sum
  end

  def part2
    parse
    identify_my_ticket.select { |k, _v| k.start_with?("departure") }.values.inject(&:*)
  end

  Field = Struct.new(:label, :range1, :range2) do
    def valid?(num)
      range1.cover?(num) || range2.cover?(num)
    end
  end

  def field(num)
    @fields[num]
  end

  attr_reader :my_ticket

  def nearby_ticket(num)
    @nearby_tickets[num]
  end

  def invalid_nearby_values
    invalid = []
    all_ranges = @fields.map { |field| [field.range1, field.range2] }.flatten
    @nearby_tickets.each do |ticket|
      ticket.each do |i|
        invalid << i if all_ranges.none? { |range| range.cover?(i) }
      end
    end
    invalid
  end

  def identify_my_ticket
    filter = my_ticket.map { (0..@fields.size - 1).to_set }
    all_ranges = @fields.map { |field| [field.range1, field.range2] }.flatten
    @nearby_tickets.each do |ticket|
      next if ticket.any? { |i| all_ranges.none? { |range| range.cover?(i) } }

      ticket.each.with_index do |value, i|
        @fields.each.with_index do |field, j|
          remove_from_filter(filter, i, j) unless field.valid?(value)
        end
      end
    end

    filter.map.with_index { |set, i| [field(set.first).label, my_ticket[i]] }.to_h
  end

  def remove_from_filter(filter, index, value)
    return unless filter[index].include?(value)

    filter[index].delete(value)
    if filter[index].size == 1
      # remaining value cannot be in any other filters either
      (0..filter.size - 1).each do |i|
        remove_from_filter(filter, i, filter[index].first) unless i == index
      end
    end
  end

  def parse
    @fields = []
    @my_ticket = []
    @nearby_tickets = []
    state = 0
    raw_input.each_line.map(&:strip).reject(&:empty?).each do |line|
      case line
      when "your ticket:"
        state = 1
      when "nearby tickets:"
        state = 2
      else
        case state
        when 0
          m = line.match(/(.*): (\d+)-(\d+) or (\d+)-(\d+)/)
          @fields << Field.new(m[1], m[2].to_i..m[3].to_i, m[4].to_i..m[5].to_i)
        when 1
          @my_ticket = line.split(",").map(&:to_i)
        when 2
          @nearby_tickets << line.split(",").map(&:to_i)
        end
      end
    end
  end
end
