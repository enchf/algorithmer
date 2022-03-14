# frozen_string_literal: true

require 'toolcase'

require 'problems/entities/invalid'
require 'problems/entities/version'

module Problems
  # Action resolver.
  class ActionFactory
    extend Toolcase::Registry

    def self.add(entity)
      register entity, tags: entity.actions
    end

    add Version

    default Invalid

    def self.resolve(action, *args)
      action = action&.to_sym
      return "Action '#{action}' is not defined" unless tags.include?(action)

      find_by(action) { |handler| handler.accept?(*args) }.new.send(action, *args)
    end
  end
end
