# frozen_string_literal: true

require 'problems/common/registry_handler'

require_relative 'expectations/invalid'
require_relative 'expectations/version'
require_relative 'expectations/unimplemented'
require_relative 'expectations/match'
require_relative 'expectations/value'

class Expectations
  INVALID_EXPECTATION = :invalid_expectation
  PROPERTIES = 

  extend Common::RegistryHandler

  def self.add(handler)
    register(handler)
    define_method(handler)
  end

  default Invalid

  add Version
  add Unimplemented
  add Match
  add Value

  def self.determine_from(config)
    find_by { |handler| handler.accept?(config) }.new(config)
  end

  private
  
  def self.define_method(handler)
    define_singleton_method(handler.name.downcase.to_sym) { handler.new }
  end
end
