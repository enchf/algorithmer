# frozen_string_literal: true

require 'toolcase'

require 'problems/entities/invalid'
require 'problems/entities/version'
require 'problems/entities/project'
require 'problems/entities/problem'
require 'problems/entities/filter'

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
    add Project
    add Problem
    add Filter

    def self.resolve(action, *args)
      action = action&.to_sym
      return "Action '#{action}' is not defined" unless registered_actions.include?(action)

      find_by(action) { |handler| handler.accept?(*args) }.execute(*args)
    end

    def self.append_invalids!
      tags.each do |tag|
        # Register invalid action.
        id = "#{tag}_default"
        register Action.new(Invalid, tag), tag: tag, id: id if ActionFactory[id].nil?
      end
    end

    append_invalids!
  end
end
