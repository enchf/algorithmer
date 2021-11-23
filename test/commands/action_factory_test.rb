# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/action_factory'

class ActionFactoryTest < Minitest::Test
  VALID_MESSAGE = 'Valid'
  SAMPLE_ACTION = ::Commands::Base::ACTIONS.sample
  ARGS = %w[arg1 arg2].freeze

  def test_respond_to_methods
    assert_respond_to tested_object, :resolve
    assert_respond_to tested_object, :registries
    assert_respond_to tested_object, :find_by
  end

  def test_invalid_action
    assert_equal 'Invalid action: invalid', tested_object.resolve(:invalid, ARGS)
  end

  def test_added_handlers
    assert_equal 11, tested_object.registries.size
  end

  def test_valid_action
    action = :run
    handler = mock
    handler.expects(action).returns(VALID_MESSAGE)

    tested_object.expects(:determine_handler).with([]).returns(handler)
    assert_equal VALID_MESSAGE, tested_object.resolve(action, [])
  end

  def test_action_accepted
    mocked_handler = mock
    mocked_handler.stubs(SAMPLE_ACTION).returns(VALID_MESSAGE)
    selected_handler = tested_object.registries.sample
    selected_handler.stubs(:new).returns(mocked_handler)

    tested_object.registries.each do |handler|
      accepted = selected_handler == handler
      handler.stubs(:accept?).returns(accepted)
      handler.any_instance.expects(SAMPLE_ACTION).never unless accepted
    end

    assert_equal VALID_MESSAGE, tested_object.resolve(SAMPLE_ACTION, ARGS)
  end

  private

  def tested_object
    Commands::ActionFactory
  end
end
