# frozen_string_literal: true

require 'test_helper'
require 'problems/components/action_builder'

class ActionBuilderTest < Minitest::Test
  ACTIONS = %i[empty_args arguments explicit].freeze
  CLASSES = [Problems::ActionWithoutArgs,
             Problems::ActionWithArguments,
             Problems::ActionWithValidators].freeze

  class Handler
    def action; end
  end

  def setup
    @builder = tested_class.new(Handler, :action)
  end

  def test_respond_to
    ACTIONS.each do |method|
      assert_respond_to @builder, method
    end
  end

  def test_build
    ACTIONS.zip(CLASSES).each do |method, action_class|
      action_class.expects(:new).once.returns(mock)
      @builder.build { send(method) }
    end
  end

  private

  def tested_class
    Problems::ActionBuilder
  end
end
