# frozen_string_literal: true

require 'test_helper'

require 'problems/validation/validator'

class ValidatorTest < Minitest::Test
  def setup
    @validator = tested_class.new
    @validator_with_predicate = tested_class.new { |*args| !args.empty? }
  end

  def test_children
    [
      tested_class.new { |*args| args.all?(&:positive?) },
      tested_class.new { |*args| args.size == 3 }
    ].each do |validator|
      @validator_with_predicate.add_child validator
    end

    assert_equal 2, @validator_with_predicate.children.size
    assert @validator_with_predicate.valid?(1, 2, 3)
    refute @validator_with_predicate.valid?(1, -2, 3)
    refute @validator_with_predicate.valid?(1, 2, 3, 4)
  end

  def test_tree_with_levels
    [
      [0, [1, 2, 3]], [4, [5, 6, 7]], [8, [9, 10]]
    ].each do |num, list|
      validator = validator_contains_number(num)
      list.each { |num_in_list| validator.add_child(validator_contains_number(num_in_list)) }
      @validator.add_child(validator)
    end

    numbers = (0..10).to_a
    assert @validator.valid?(*numbers)
    refute @validator.valid?(*numbers.take(10))
  end

  def test_accept?
    refute @validator_with_predicate.valid?
    assert @validator_with_predicate.valid?(1, 2, 3)
  end

  def test_default_predicate
    assert @validator.valid?
    assert @validator.valid?(1, 2, 3)
  end

  def tested_class
    Problems::Validator
  end

  def validator_contains_number(num)
    tested_class.new { |*args| args.include?(num) }
  end
end
