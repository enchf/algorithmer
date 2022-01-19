# frozen_string_literal: true

require 'test_helper'
require 'problems/components/action_without_args'

class ActionWithoutArgsTest < Minitest::Test
  def test_validate_no_args
    action = tested_class.new(mock, mock)

    assert action.arguments.empty?
    assert action.accept?
    refute action.accept?(1, 2, 3)
  end

  private

  def tested_class
    Problems::ActionWithoutArgs
  end
end
