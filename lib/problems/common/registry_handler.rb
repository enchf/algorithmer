# frozen_string_literal: true

module Common
  # Mixin encapsulating a handlers registry.
  module RegistryHandler
    def register(handler)
      actions[handler.key] = handler
    end

    def default(handler)
      actions.default = handler
    end

    def actions
      @@actions ||= Hash.new
    end
  end
end
