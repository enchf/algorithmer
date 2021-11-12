# frozen_string_literal: true

require 'problems/common/registry_handler'

require_relative 'entities/base'
require_relative 'entities/invalid'

require_relative 'entities/empty'
require_relative 'entities/project'

# require_relative 'entities/problem'
# require_relative 'entities/tag'
# require_relative 'entities/title'
# require_relative 'entities/description'
# require_relative 'entities/url'
# require_relative 'entities/filter'
# require_relative 'entities/test'
# require_relative 'entities/solution'

module Commands
  # Action resolver.
  class ActionFactory
    extend Common::RegistryHandler

    key(&:itself)

    default Invalid

    register Empty
    register Project

    # register Problem
    # register Tag
    # register Title
    # register Description
    # register Url
    # register Filter

    # register Test
    # register Solution

    resolver do |action, args|
      Base::ACTIONS.include?(action) ? determine_handler(args).send(action) : "Invalid action: #{action}"
    end

    def self.determine_handler(args)
      all_registries
        .find(registry.default) { |type| type.accept?(args) }
        .new(args)
    end
  end
end
