require "day4"

class Day4Test < Minitest::Test
  TEST_INPUT = <<~END
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929

    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm

    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in
  END

  def test_part1
    d4 = Day4.new(TEST_INPUT)
    assert_equal 4, d4.passports.size
    assert d4.passports[0].valid?
    refute d4.passports[1].valid?
    assert d4.passports[2].valid?
    refute d4.passports[3].valid?
    assert_equal 2, d4.part1
  end
end
