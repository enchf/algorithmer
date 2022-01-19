# frozen_string_literal: true

require_relative 'validator'

module Problems
  # Validator for an indexed property.
  class IndexedValidator < Validator
    attr_accessor :index

    def initialize(index, use_and: true, &predicate)
      super(use_and: use_and, &predicate)
      @index = index
    end

    def arguments(*args)
      [args[index]]
    end
  end
end
