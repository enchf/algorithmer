# frozen_string_literal: true

require 'forwardable'
require 'problems/common/registry_handler'

module Commands
  # Base entity class.
  # Define accepted actions and a default behavour for them.
  class Base
    ACTIONS = %i[add edit remove show list init run version].freeze

    ACTIONS.each do |action|
      define_method(action) do
        "Action #{action} is not defined for #{object_name}"
      end
    end

    extend Common::RegistryHandler

    class << self
      extend Forwardable

      def_delegator :self, :register, :validator
      def_delegator :self, :registries, :validators
    end

    def initialize(*_); end

    def self.accept?(*args)
      validators.reduce(true) { |acc, validator| acc && validator.call(*args) }
    end

    def object_name
      self.class.name.split('::').last.downcase
    end

    def self.args_size(size)
      proc { |*args| args.size == size }
    end

    def self.keyword(keyword, index)
      proc { |*args| args[index] == keyword }
    end

    def self.valid_argument(regex, index)
      proc { |*args| valid_value(regex).call(args[index]) }
    end

    def self.valid_value(regex)
      proc { |value| regex.match?(value) }
    end
  end
end
