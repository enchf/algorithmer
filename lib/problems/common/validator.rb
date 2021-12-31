# frozen_string_literal: true

require 'toolcase'

module Problems
  # Generic validator
  class Validator
    include Toolcase::Registry

    alias :registries, :children
    alias :register, :add_child

    def initialize(and = true, &predicate)
      @reductor = and ? :all? : :any?
      @predicate = block_given? ? predicate : default_predicate
    end

    def valid?(*args)
      @predicate.call(*args) && children.send(@reductor) { |child| child.valid?(*args) }
    end

    def default_predicate
      proc { |*_| true }
    end
  end
end
