# frozen_string_literal: true

require 'test_helper'
require 'problems/validation/validator'
require 'problems/components/action_with_validators'

class ActionWithValidatorsTest < Minitest::Test
  def test_add_validators
    action = tested_class.new(mock, mock) do
      add Problems::Validator.new
      add Problems::Validator.new
    end

    assert_equal 2, action.validations.size
  end

  private

  def tested_class
    Problems::ActionWithValidators
  end
end
