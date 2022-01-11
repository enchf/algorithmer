# frozen_string_literal: true

require 'problems/common/validator'
require 'problems/components/entity'

class EntityTest < Minitest::Test
  class TestEntity < Problems::Entity
    action :test do
      [
        Problems::Validator.new { |*args| args.all?(&:positive?) },
        Problems::Validator.new { |*args| !args.empty? }
      ].each do |validator|
        root_validator.add_child(validator)
      end
    end

    def test(*numbers)
      numbers.reduce(&:+)
    end
  end

  def test_register_action
    actions = TestEntity.actions
    assert_equal 1, actions.size

    action = actions.first
    assert action.accept?(1, 2, 3)
    refute action.accept?(0, 1, 2, 3)
    refute action.accept?

    assert_equal 6, action.execute(1, 2, 3)
  end
end
