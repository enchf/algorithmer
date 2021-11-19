# frozen_string_literal: true

require 'forwardable'

module Common
  # Mixin encapsulating a handlers registry.
  module RegistryHandler
    extend Forwardable

    def_delegator :registries, :include?

    def registries
      @registries ||= []
    end

    def default(value = nil)
      @default = value unless value.nil?
      return @default if defined? @default

      nil
    end

    def register(registry = nil, &block)
      element = nil
      element = registry unless registry.nil?
      element = block if block_given?
      registries << element unless element.nil? || include?(element)
    end

    def find_by(&block)
      registries.find(-> { default }, &block)
    end

    def inherited(child)
      super
      child.registries.concat(registries)
      child.default(default)
    end
  end
end
