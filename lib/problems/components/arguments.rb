# frozen_string_literal: true

require 'toolcase'

require 'problems/validation/argument_provider'
require 'problems/validation/leaves'
require 'problems/validation/validator_builder'

# An special case of a validator to bijectively assign a validator per input argument.
module Problems
  class Arguments
    include Toolcase::Registry

    class << self
      def build(&block)
        container = Arguments.new(&block)
        ValidatorBuilder.new
                        .predicate(&container.valid_arity?)
                        .append_all(container.registries)
                        .build
      end

      def import_predicates!(source, methods)
        methods.each do |method|
          Arguments.define_method(method) do |*args|
            predicate = source.send(method, *args)
            register ValidatorBuilder.new
                                .argument_provider(ArgumentProvider.by_index(size))
                                .predicate(&predicate)
                                .build
          end
        end
      end
    end

    import_predicates!(Leaves, Leaves.exportable_methods)

    def initialize(&block)
      instance_eval(&block) if block_given?
    end

    def valid_arity?
      proc do |*args|
        arity.include?(args.size)
      end
    end

    def arity
      size..size
    end
  end
end
