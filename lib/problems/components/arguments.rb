# frozen_string_literal: true

require 'toolcase'

module Problems
  # Arguments definition.
  class Arguments
    include Toolcase::Registry

    alias validators registries

    def reserved_word(name)
      validator argument: false do |value|
        name.to_s == value
      end
    end

    def format(regexp)
      validator do |value|
        regexp.match?(value)
      end
    end

    def initialize(&block)
      instance_eval(&block)
    end

    def arguments
      registries(:arguments)
    end

    private

    def validator(argument: true, &block)
      register IndexedValidator.new(size, &block), tag: argument ? :argument : nil
    end
  end
end
