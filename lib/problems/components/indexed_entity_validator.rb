# frozen_string_literal: true

module Problems
  # Indexed validator wrapped by an entity
  class IndexedEntityValidator < IndexedValidator
    attr_accessor :entity

    def initialize(index, entity, use_and: true, &predicate)
      super(index, use_and: use_and, &predicate)
      @entity = entity
    end
  end
end
