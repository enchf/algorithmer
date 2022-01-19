# frozen_string_literal: true

require 'toolcase'

module Problems
  # Generic validator
  class Validator
    include Toolcase::Registry

    attr_accessor :predicate, :reductor

    alias children registries
    alias add_child register

    def initialize(use_and: true, &predicate)
      @predicate = block_given? ? predicate : default_predicate
      @reductor = use_and ? :all? : :any?
    end

    def valid?(*args)
      final_args = arguments(*args)
      @predicate.call(*final_args) && children.send(@reductor) { |child| child.valid?(*final_args) }
    end

    def default_predicate
      proc { |*_| true }
    end

    def arguments(*args)
      args
    end
  end
end
