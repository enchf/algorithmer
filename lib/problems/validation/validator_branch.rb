# frozen_string_literal: true

require 'toolcase'

require_relative 'argument_provider'
require_relative 'leaves'
require_relative 'validator_builder'

# An special case of a validator to bijectively assign a validator per input argument.
module Problems
  class ValidatorBranch
    include Toolcase::Registry

    INDEXED_CHILDREN = proc { ArgumentProvider.by_index(size) }
    SINGLE_VALUE = proc { ArgumentProvider.single_value }

    ## -- Predicates as DSL

    def self.import_predicates!(source, *methods)
      methods.each do |method|
        ValidatorBranch.define_method(method) do |*args|
          predicate = source.send(method, *args)
          provider = @provider_generator.call
          register ValidatorBuilder.new
                              .argument_provider(provider)
                              .predicate(&predicate)
                              .build
        end
      end
    end

    import_predicates!(Leaves, *Leaves.exportable_methods)

    ## -- Generators

    def self.for_arguments(&block)
      container = ValidatorBranch.new(INDEXED_CHILDREN, &block)
      ValidatorBuilder.new
                      .predicate(&container.valid_arity?)
                      .append_all(container.registries)
                      .build
    end

    def self.for_single_value(&block)
      container = ValidatorBranch.new(SINGLE_VALUE, &block)
      ValidatorBuilder.new
                      .append_all(container.registries)
                      .build
    end

    def self.for_specific_provider(provider, &block)
      container = ValidatorBranch.new(proc { provider }, &block)
      ValidatorBuilder.new
                      .append_all(container.registries)
                      .build
    end
    
    def self.as_proc(&block)
      for_single_value(&block).to_predicate
    end

    ## -- Instance methods

    def valid_arity?
      proc do |*args|
        arity.include?(args.size)
      end
    end

    def arity
      size..size
    end 

    protected

    def initialize(provider_generator, &block)
      @provider_generator = provider_generator
      instance_eval(&block) if block_given?
    end
  end
end
