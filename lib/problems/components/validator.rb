# frozen_string_literal: true

require 'toolcase'

module Problems
  # Generic validator
  class Validator
    include Toolcase::Registry

    alias children registries
    alias add_child register

    def initialize(use_and: true, &predicate)
      @predicate = block_given? ? predicate : default_predicate
      @reductor = use_and ? :all? : :any?
    end

    def valid?(*args)
      @predicate.call(*args) && children.send(@reductor) { |child| child.valid?(*args) }
    end

    def default_predicate
      proc { |*_| true }
    end
  end
end
