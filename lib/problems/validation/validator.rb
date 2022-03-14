# frozen_string_literal: true

require 'toolcase'

module Problems
  # Generic validator
  class Validator
    def initialize(reductor, children, &predicate)
      @reductor = reductor
      @children = children.freeze
      @predicate = predicate
    end

    def valid?(*args)
      final_args = arguments(*args)
      predicate.call(*final_args) && children_valid?(*args)
    end

    protected

    def arguments(*args)
      args
    end

    def children_valid?(*args)
      children.empty? || children.send(reductor) { |child| child.valid?(*args) }
    end
  end
end
