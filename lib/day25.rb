class Day25 < Base
  def part1
    door_pk, card_pk = raw_input.each_line.map(&:to_i)
    door_ls = rev_transform(subject: 7, value: door_pk)
    card_ls = rev_transform(subject: 7, value: card_pk)
    transform(subject: door_pk, loop_size: card_ls)
  end

  def transform(subject:, loop_size:)
    value = 1
    loop_size.times do
      value *= subject
      value = value.remainder(20201227)
    end
    value
  end

  def rev_transform(subject:, value:)
    loop_size = 0
    v = 1
    while v != value
      loop_size += 1
      v *= subject
      v = v.remainder(20201227)
    end
    loop_size
  end
end
