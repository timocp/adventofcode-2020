require "set"

class Day21 < Base
  def part1
    parse
    reduce_allergens

    # ingredients that can't possible contain any of the allergens from the
    # list
    safe_food = @ingredients.keys - @allergens.values

    # number of times they appear
    safe_food.map { |ingredient| @ingredients[ingredient] }.sum
  end

  def part2
    parse
    reduce_allergens

    # dangerous ingredient list
    @allergens.sort_by { |allergen, _ingredient| allergen }.map(&:last).join(",")
  end

  def reduce_allergens
    # iterate over @allergens looking for allergens which map exactly to an
    # ingredient.
    # - the set is replaced by a string.
    # - remove the ingredient from other sets.
    # - keep going until all sets contain exactly one ingredient.
    unknowns = Set.new(@allergens.keys)
    while unknowns.any?
      allergen, ingredient = @allergens.detect { |k, v| unknowns.include?(k) && v.size == 1 }
      ingredient = ingredient.first
      # warn "allergen #{allergen} must be #{ingredient}"
      unknowns.delete(allergen)
      @allergens.each { |k, v| v.delete(ingredient) unless k == allergen }
      @allergens[allergen] = ingredient
    end
  end

  def parse
    @ingredients = Hash.new(0) # key: ingredient, value: count in input
    @allergens = {} # key: allergen, value: set of ingredients it COULD be
    raw_input.each_line do |line|
      m = line.match(/^(.*) \(contains (.*)\)$/)
      ingredients = m[1].split(" ")
      allergens = m[2].split(", ")
      ingredients.each { |ingredient| @ingredients[ingredient] += 1 }
      allergens.each do |allergen|
        if @allergens.key?(allergen)
          @allergens[allergen] &= ingredients
        else
          @allergens[allergen] = Set.new(ingredients)
        end
      end
    end
  end
end
