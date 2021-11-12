# frozen_string_literal: true

require 'forwardable'

module Common
  # Mixin encapsulating a handlers registry.
  module RegistryHandler
    extend Forwardable

    def_delegator :registry, :values, :all_registries

    def register(handler)
      registry[@key_provider.call(handler)] = handler
    end

    def default(handler)
      registry.default = handler
    end

    def registry
      @registry ||= {}
    end

    def key(&key_provider)
      @key_provider ||= key_provider unless key_provider.nil?
    end

    # Determines which entry in registry correspond to the arguments.
    def resolver(&block)
      @resolver ||= block
    end

    def resolve(*args)
      @resolver.call(*args)
    end
  end
end
