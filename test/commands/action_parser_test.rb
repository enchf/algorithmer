# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/action_parser'

class ActionParserTest < Minitest::Test
  KNOWN_ACTIONS = %w[add edit init list remove run show].freeze

  def test_respond_to_resolve
    assert_respond_to tested_object, :resolve
  end

  def test_version_shown
    assert_includes tested_object.resolve('-v'), ::Problems::VERSION
  end

  def test_default_behaviour
    assert_includes tested_object.resolve, ::Problems::VERSION
  end

  def test_unknown_action
    assert_equal 'Action not recognized: invalid', tested_object.resolve('invalid')
  end

  def test_known_actions
    KNOWN_ACTIONS.each do |action|
      random_args = Array.new(random_digit) { random_digit }
      expected_response = "Command #{action} invoked with args: #{random_args}"
      assert_equal expected_response, tested_object.resolve(action, random_args), "Testing #{action}"
    end
  end

  private

  def tested_object
    Commands::ActionParser
  end

  def random_digit
    (rand * 10).to_i
  end
end
