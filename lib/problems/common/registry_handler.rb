# frozen_string_literal: true

module Common
  # Mixin encapsulating a handlers registry.
  module RegistryHandler
    def register(handler)
      actions[@key_provider.call(handler)] = handler
    end

    def default(handler)
      actions.default = handler
    end

    def actions
      @actions ||= {}
    end

    def key(&key_provider)
      @key_provider ||= key_provider unless key_provider.nil?
    end

    def resolver(&block)
      @resolver ||= block
    end

    def resolve(*args)
      @resolver.call(*args)
    end
  end
end
