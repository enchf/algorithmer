# frozen_string_literal: true

require 'toolcase'

require 'problems/entities/version'

module Problems
  # Action resolver.
  class ActionFactory
    extend Toolcase::Registry

    def self.add(handler)
      handler.actions.each do |action|
        register action, tag: action.name
      end
    end

    class << self
      alias registered_actions tags
    end

    add Version

    def self.resolve(action, *args)
      # TODO: Remove null-safe operation when default handler is registered.
      find_by(action.to_sym) { |handler| handler.accept?(*args) }&.execute(*args)
    end
  end
end
