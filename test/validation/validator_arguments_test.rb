# frozen_string_literal: true

require 'test_helper'

require 'problems/validation/validator'

class ValidatorArgumentsTest < Minitest::Test
  def setup; end

  def test_indexed_validator
    validator = tested_class.new(arguments: tested_class.indexed_argument(2)) { |val| val == 100 }

    assert validator.valid?(100, 100, 100)
    assert validator.valid?(1, 2, 100)
    refute validator.valid?(1, 2, 3)
  end

  def tested_class
    Problems::Validator
  end
end
