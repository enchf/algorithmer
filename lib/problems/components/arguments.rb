# frozen_string_literal: true

require 'toolcase'

require 'problems/validation/argument_provider'
require 'problems/validation/leaves'
require 'problems/validation/validator_builder'

# An special case of a validator to bijectively assign a validator per input argument.
module Problems
  class Arguments
    include Toolcase::Registry

    Leaves.integrate!(Arguments) do |predicate|
      register ValidatorBuilder.new
                               .argument_provider(ArgumentProvider.by_index(size))
                               .predicate(&predicate)
                               .build
    end

    def self.build(&block)
      container = Arguments.new(&block)
      ValidatorBuilder.new
                      .append_all(container.registries)
                      .build
    end
  end
end
