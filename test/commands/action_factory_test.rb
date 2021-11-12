# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/action_factory'

class ActionFactoryTest < Minitest::Test
  KNOWN_ACTIONS = %w[add edit init list remove run show].freeze

  def test_respond_to_resolve
    assert_respond_to tested_object, :resolve
  end

  private

  def tested_object
    Commands::ActionFactory
  end
end
