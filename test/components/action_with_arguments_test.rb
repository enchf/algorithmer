# frozen_string_literal: true

require 'test_helper'
require 'problems/components/action_with_arguments'

class ActionWithArgumentsTest < Minitest::Test
  def setup
    @arguments = mock
    @context = mock

    build_mocks
  end

  def test_context
    argument = mock
    argument.stubs(:entity).returns(:project)

    @arguments.stubs(:validators).returns([])
    @arguments.stubs(:arguments).returns([[argument, 0]])

    @context.expects(:property).with(0, :project).once

    initialize_tested_class
  end

  def test_validators
    validator = mock

    @arguments.stubs(:arguments).returns([])
    @arguments.stubs(:validators).returns([[validator, 0]])

    action = initialize_tested_class
    refute action.validations.children.empty?
  end

  private

  def initialize_tested_class
    tested_class.new(mock, mock)
  end

  def build_mocks
    Problems::Context.stubs(:new).returns(@context)
    Problems::Arguments.stubs(:new).returns(@arguments)
  end

  def tested_class
    Problems::ActionWithArguments
  end
end
