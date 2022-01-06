# frozen_string_literal: true

require 'problems/common/entity'
require 'problems/common/validator'

class EntityTest < Minitest::Test
  class TestEntity < Problems::Entity
    validations do
      empty_args = Problems::Validator.new { |*args| !args.empty? }
      add_child empty_args
    end

    action :test do
      all_positive = Problems::Validator.new { |*args| args.all?(&:positive?) }
      add_child all_positive
    end

    def test(*numbers)
      numbers.reduce(&:+)
    end
  end

  def test_entity_validations
    validations = TestEntity.validations
    validator = Problems::Validator.new.instance_eval(&validations)

    assert validator.valid?(1, 2, 3)
    refute validator.valid?
  end

  def test_register_action
    actions = TestEntity.actions
    assert_equal 1, actions.size

    action = actions.first
    assert action.accept?(1, 2, 3)
    refute action.accept?(0, 1, 2, 3)
    refute action.accept?
  end
end
