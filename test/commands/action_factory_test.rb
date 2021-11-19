# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/action_factory'

class ActionFactoryTest < Minitest::Test
  VALID_MESSAGE = 'Valid'
  INVALID_MESSAGE = 'Invalid'
  SAMPLE_ACTION = ::Commands::Base::ACTIONS.sample

  def test_respond_to_methods
    assert_respond_to tested_object, :resolve
    assert_respond_to tested_object, :registries
    assert_respond_to tested_object, :find_by
  end

  def test_invalid_action
    assert_equal 'Invalid action: invalid', tested_object.resolve(:invalid, %w[arg1 arg2])
  end

  def test_added_handlers
    assert_equal 10, tested_object.registries.size
  end

  def test_valid_action
    action = :run
    handler = mock
    handler.expects(action).returns(VALID_MESSAGE)

    tested_object.expects(:determine_handler).with([]).returns(handler)
    assert_equal VALID_MESSAGE, tested_object.resolve(action, [])
  end

  def test_action_accepted
    handler_index = rand(tested_object.registries.size)

    tested_object.registries.each_with_index do |handler, i|
      accepted = handler_index == i
      handler.stubs(:accept?).returns(accepted)
      handler.any_instance.stubs(SAMPLE_ACTION).returns(accepted ? VALID_MESSAGE : INVALID_MESSAGE)
    end

    assert_equal VALID_MESSAGE, tested_object.resolve(SAMPLE_ACTION, %w[arg1 arg2])
  end

  private

  def tested_object
    Commands::ActionFactory
  end
end
