# frozen_string_literal: true

require 'test_helper'
require 'problems/components/action_with_arguments'

class ActionWithArgumentsTest < Minitest::Test
  def setup
    @context = mock
    Problems::Context.stubs(:new).returns(@context)
  end

  def test_initialized_with_block
    argument = validator_mock
    argument.stubs(:entity).returns(:project)

    @context.expects(:property).with(0, :project).once

    initialize_tested_class do
      add_validator argument
    end
  end

  def test_next_index
    validator = validator_mock
    action = initialize_tested_class do
      add_validator validator, argument: false
      add_validator validator
    end
    assert 2, action.next_index
  end

  def test_varargs
    mock_context
    one, two, custom, other = equal_validators(1, 2, 3, 4)

    action = initialize_tested_class do
      add_validator one
      add_validator two
      varargs do
        any do
          add_child custom
          add_child other
        end
      end
    end

    assert action.accept?(1, 2, 3, 4)
    refute action.accept?(1, 2, 1, 2)
    refute action.accept?(1, 1, 3, 4)
  end

  def test_reserved_word
    mock_context
    dummy = validator.new

    action = initialize_tested_class do
      add_validator dummy
      reserved_word :or
      add_validator dummy
    end

    assert action.accept?(1, :or, 2)
    refute action.accept?(1, :and, 2)
    refute action.accept?(1, 2, :or)
  end

  def test_format
    mock_context
    action = initialize_tested_class do
      format(/^[0-9]+$/)
    end

    assert action.accept?('123')
    assert action.accept?('1')
    refute action.accept?('12-3')
    refute action.accept?('')
  end

  def test_any
    mock_context
    one, two, three = equal_validators(1, 2, 3)
    action = initialize_tested_class do
      any do
        add_child one
        add_child two
      end
      add_validator three
    end

    assert action.accept?(1, 3)
    assert action.accept?(2, 3)
    refute action.accept?(3, 3)
    refute action.accept?(1, 3, 4)
    refute action.accept?(1, 1)
  end

  def test_optional
    mock_context
    one = equal_validators(1).first
    action = initialize_tested_class do
      optional do
        add_child one
      end
    end

    assert action.accept?
    assert action.accept?(1)
    refute action.accept?(2)
    refute action.accept?(1, 2)
  end

  private

  def initialize_tested_class(&block)
    tested_class.new(mock, mock, &block)
  end

  def tested_class
    Problems::ActionWithArguments
  end

  def validator
    Problems::Validator
  end

  def validator_mock(*methods)
    mock.tap do |validator|
      validator.stubs(:arguments=)
      methods.each { |method| validator.stubs(method) }
    end
  end

  def mock_context
    @context.stubs(:property)
  end

  def equal_validators(*values)
    values.map { |val| validator.new { |value| value == val } }
  end
end
