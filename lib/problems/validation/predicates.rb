# frozen_string_literal: true

require 'problems/components/action_with_arguments'
require_relative 'validator'

module Problems
  # Pre-defined predicates for validators
  module Predicates
    EXECUTOR = Object.new.extend(Predicates)

    def reserved_word(word, **config)
      Predicates.predicate_as_validator(**config) { |value| word.to_s == value.to_s }
    end

    def format(regex, **config)
      Predicates.predicate_as_validator(**config) { |value| regex.match?(value.to_s) }
    end

    def any(**config, &block)
      config[:reductor] = Validator.any
      config[:arguments] ||= Validator.default_arguments
      Predicates.block_as_validator(**config, &block)
    end

    def optional(**config, &block)
      any(**config) do
        add_child Predicates.predicate_as_validator(**config) { |*args| args.nil? || args.empty? }
        add_child Predicates.block_as_validator(**config, &block)
      end
    end

    class << self
      # Util methods
      def predicate_as_validator(**config, &block)
        Validator.new(**config, &block)
      end

      def block_as_validator(**config, &block)
        Validator.new(**config).evaluate(&block)
      end

      def all
        Predicates.instance_methods(false)
      end

      def missing_methods_in(target_class)
        all.reject { |method| target_class.instance_methods(false).include?(method) }
      end

      # Integration

      private

      # Integrate to Validator
      def build_validator_dsl!
        missing_methods_in(Validator).each do |method|
          Validator.define_method(method) do |*args, **new_config, &block|
            final_config = config.merge(new_config)
            add_child EXECUTOR.send(method, *args, **final_config, &block)
          end
        end
      end

      # Integrate to ActionWithArguments to validate arguments
      def build_action_dsl!
        missing_methods_in(ActionWithArguments).each do |method|
          ActionWithArguments.define_method(method) do |*args, **config, &block|
            validator = EXECUTOR.send(method, *args, **config, &block)
            argument = !ActionWithArguments::EXCLUDE_FROM_ARGUMENTS.include?(method)
            add_validator(validator, argument: argument, type: method)
          end
        end
      end

      public

      def build_dsl!
        build_validator_dsl!
        build_action_dsl!
      end
    end

    build_dsl!
  end
end
