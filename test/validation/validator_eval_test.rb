# frozen_string_literal: true

require 'test_helper'

require 'problems/validation/validator'

class ValidatorEvalTest < Minitest::Test
  def test_add_child_validator_in_block
    validator = tested_class.new
    child = tested_class.new
    validator.evaluate do
      add_child child
    end
    assert 1, validator.children.size
  end

  def tested_class
    Problems::Validator
  end
end
