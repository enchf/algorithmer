# frozen_string_literal: true

require 'test_helper'

require 'problems/components/action'
require 'problems/components/validator'

class ActionTest < Minitest::Test
  class Handler
    def sum(left, right)
      left + right
    end
  end

  def setup
    @action = tested_class.new Handler, :sum
    @action.validations.add_child all_numeric
  end

  def test_execution
    assert_equal 3, @action.execute(1, 2)
  end

  def test_accept
    assert @action.accept?(1, 2)
    refute @action.accept?(1, '2')
  end

  private

  def tested_class
    Problems::Action
  end

  def all_numeric
    Problems::Validator.new { |*args| args.all? { |arg| arg.is_a? Numeric } }
  end
end
