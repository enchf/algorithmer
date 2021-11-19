# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/entities/base'

class BaseTest < Minitest::Test
  class Entity < ::Commands::Base
    validator { |arg, *_| arg == 'arg1' }
    register { |*args| args.size > 1 }
  end

  def test_respond_to
    %i[register validator validators].product([tested_class, Entity]).each do |method, clazz|
      assert_respond_to clazz, method, "Testing #{method} in #{clazz}"
    end
  end

  def test_number_of_validators
    entity_validators = 2
    assert_equal entity_validators, Entity.validators.size
    Entity.validator { |args| args.include?('arg') }
    assert_equal entity_validators + 1, Entity.validators.size
  end

  def test_accept?
    assert Entity.accept?('arg1', 'arg2')

    refute Entity.accept?('arg1')
    refute Entity.accept?
    refute Entity.accept?(nil, nil)
    refute Entity.accept?(nil)
  end

  def test_object_name
    assert_equal 'entity', Entity.new.object_name
  end

  private

  def tested_class
    ::Commands::Base
  end
end
