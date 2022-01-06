# frozen_string_literal: true

require 'test_helper'
require 'problems/common/action'

class ActionTest < Minitest::Test
  class Handler
    def run(left, right)
      left + right
    end
  end

  def setup
    @action = Problems::Action.new(Handler, :run)
    @validator = Problems::Validator.new { |*args| args.all? { |arg| arg.is_a? Numeric } }
  end

  def test_execution
    assert_equal 3, @action.execute(1, 2)
  end

  def test_validations
    @action.add_validations do
      add_child @validator
    end
    assert @action.accept?(1, 2)
  end
end
