# frozen_string_literal: true

require 'test_helper'
require 'problems/components/action_with_arguments'

class ActionWithArgumentsTest < Minitest::Test
  def setup
    @context = mock
    Problems::Context.stubs(:new).returns(@context)
  end

  def test_initialized_with_block
    argument = mock
    argument.stubs(:entity).returns(:project)

    @context.expects(:property).with(0, :project).once

    initialize_tested_class do
      add_child argument, tag: :argument
    end
  end

  def test_next_index; end

  def test_varargs; end

  def test_reserved_word; end

  def test_format; end

  def test_any; end

  def test_optional; end

  private

  def initialize_tested_class(&block)
    tested_class.new(mock, mock, &block)
  end

  def tested_class
    Problems::ActionWithArguments
  end
end
