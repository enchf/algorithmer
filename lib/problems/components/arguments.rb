# frozen_string_literal: true

require 'toolcase'

module Problems
  # Arguments definition.
  class Arguments
    include Toolcase::Registry

    alias validators registries

    def keyword(name)
      register_non_argument do |value|
        name.to_s == value
      end
    end

    def initialize(&block)
      instance_eval(&block)
    end

    def arguments
      registries(:arguments)
    end

    private

    def register_argument(&block)
      add_validator(:arguments, &block)
    end

    def register_non_argument(&block)
      add_validator(&block)
    end

    def add_validator(tag = nil, &block)
      validator = IndexedValidator.new(size, &block)
      register validator, tag: tag
    end
  end
end
