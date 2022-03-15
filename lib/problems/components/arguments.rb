# frozen_string_literal: true

require 'problems/validation/validator_builder'

# An special case of a validator to bijectively assign a validator per input argument.
class Arguments
  def self.build(&block)
    ValidatorBuilder.new.tap do |builder|
      Arguments.new(&block)
               .registries
               .each_with_index do |(predicate, argument_provider), index|
        child = ValidatorBuilder.new
                                .argument_provider(argument_provider)
                                .predicate(&predicate)
                                .build
        builder.append(child)
      end
    end.build
  end
end
