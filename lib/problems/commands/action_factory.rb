# frozen_string_literal: true

require 'problems/common/registry_handler'

module Commands
  # Action resolver.
  class ActionFactory
    ACTIONS = %i[add edit remove show list init run version]

    extend Common::RegistryHandler

    register Project
    
    register Problem
    register Tag
    register Title
    register Description
    register Url
    register ProblemFilter
    
    register Test
    register Solution

    default InvalidObject

    resolver do |action, args|
      return "Invalid action: #{action}" unless ACTIONS.include?(action)
      
      determine_handler(action, args).send(action)
    end
    
    def self.determine_handler(args)
      types = registry.select { |handler| handler.accept?(args) }
      raise "More than one handler (#{types.map(&:name)} can be interpreted with this values: #{args}" if types.size > 1

      types&.first || default
    end
  end
end
