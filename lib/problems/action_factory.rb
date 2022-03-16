# frozen_string_literal: true

require 'toolcase'

require 'problems/entities/invalid'
require 'problems/entities/version'
require 'problems/entities/project'
require 'problems/entities/problem'

module Problems
  # Action resolver.
  class ActionFactory
    extend Toolcase::Registry

    def self.add(entity)
      register entity, tags: entity.actions
    end

    add Version
    add Project
    add Problem

    default Invalid

    def self.resolve(action, *args)
      action = action&.to_sym
      return "Action '#{action}' is not defined" unless tags.include?(action)

      find_by(action) { |handler| handler[action].valid?(*args) }.new.send(action, *args)
    end
  end
end
