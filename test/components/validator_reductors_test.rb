# frozen_string_literal: true

require 'test_helper'

require 'problems/components/validator'

class ValidatorReductorsTest < Minitest::Test
  def setup
    @or_validator = tested_class.new(reductor: tested_class.any)
  end

  def test_or_validator
    [1, 2, 3].map { |num| tested_class.new { |*args| args.first == num } }
             .each { |validator| @or_validator.add_child validator }
    [1, 2, 3].each { |num| assert @or_validator.valid?(num, 5, 6) }
    refute @or_validator.valid?(0, 1)
  end

  def tested_class
    Problems::Validator
  end
end
