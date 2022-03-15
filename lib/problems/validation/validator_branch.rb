# frozen_string_literal: true

require_relative 'leafs'
require_relative 'validator'
require_relative 'validator_builder'

module Problems
  # Validator constructor from arguments.
  class ValidatorBranch
    # initializer
    Leafs.integrate!(ValidatorBranch) do |predicate|
      @builder.append ValidatorBuilder.new
                                      .argument_provider(@provider)
                                      .predicate(&predicate)
                                      .build
    end

    def initialize(provider)
      @provider = provider
      @builder = ValidatorBuilder.new
    end

    def build
      @builder.build
    end
  end
end
