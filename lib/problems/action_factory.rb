# frozen_string_literal: true

require 'toolcase'

require 'problems/entities/invalid'
require 'problems/entities/version'
require 'problems/entities/project'

module Problems
  # Action resolver.
  class ActionFactory
    extend Toolcase::Registry

    def self.add(handler)
      handler.actions.each do |action|
        register action, tag: action.name

        # Register invalid action.
        id = "#{action}_default"
        register Action.new(Invalid, action.name), tag: action.name, id: id if ActionFactory[id].nil?
      end
    end

    class << self
      alias registered_actions tags
    end

    add Version
    add Project

    def self.resolve(action, *args)
      action = action&.to_sym
      return "Action '#{action}' is not defined" unless registered_actions.include?(action)

      find_by(action) { |handler| handler.accept?(*args) }.execute(*args)
    end
  end
end
