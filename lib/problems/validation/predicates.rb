# frozen_string_literal: true

require_relative 'validator'

module Problems
  # Pre-defined predicates for validators
  module Predicates
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

    # Util methods
    def self.predicate_as_validator(**config, &block)
      Validator.new(**config, &block)
    end

    def self.block_as_validator(**config, &block)
      Validator.new(**config).evaluate(&block)
    end

    def self.all
      Predicates.instance_methods(false)
    end

    # Integrate to Validator
    all.each do |method|
      executor = Object.new.extend(Predicates)
      Validator.define_method(method) do |*args, **new_config, &block|
        final_config = config.merge(new_config)
        add_child executor.send(method, *args, **final_config, &block)
      end
    end
  end
end
