# frozen_string_literal: true

require 'problems/common/registry_handler'

require_relative 'entities/base'
require_relative 'entities/invalid'

require_relative 'entities/empty'
require_relative 'entities/project'

require_relative 'entities/problem'
require_relative 'entities/tag'
require_relative 'entities/title'
require_relative 'entities/description'
require_relative 'entities/url'
require_relative 'entities/property_remover'
require_relative 'entities/filter'

require_relative 'entities/test'
require_relative 'entities/numbered_test'
require_relative 'entities/solution'
require_relative 'entities/numbered_solution'

module Commands
  # Action resolver.
  class ActionFactory
    extend Common::RegistryHandler

    default Invalid

    register Empty
    register Project

    register Problem
    register Tag
    register Title
    register Description
    register Url
    register PropertyRemover
    register Filter

    register Test
    register NumberedTest
    register Solution
    register NumberedSolution

    def self.resolve(action, args)
      Base::ACTIONS.include?(action) ? determine_handler(args).send(action) : "Invalid action: #{action}"
    end

    def self.determine_handler(*args)
      find_by { |type| type.accept?(*args) }.new(*args)
    end
  end
end
