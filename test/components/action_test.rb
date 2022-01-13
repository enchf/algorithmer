# frozen_string_literal: true

require 'test_helper'
require 'problems/common/validator'
require 'problems/components/action'

class ActionTest < Minitest::Test
  class Handler
    def sum(left, right)
      left + right
    end
  end

  def setup
    @action = tested_class.new Handler,
                               :sum,
                               Problems::Validator.new.tap { |it| it.add_child(all_numeric) },
                               tested_class::DEFAULT_ARG_PROVIDER,
                               nil
  end

  def test_execution
    assert_equal 3, @action.execute(1, 2)
  end

  def test_accept
    assert @action.accept?(1, 2)
  end

  private

  def tested_class
    Problems::Action
  end

  def all_numeric
    Problems::Validator.new { |*args| args.all? { |arg| arg.is_a? Numeric } }
  end
end
