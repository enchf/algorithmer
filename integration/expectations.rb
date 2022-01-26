# frozen_string_literal: true

require 'toolcase'

require_relative 'expectations/invalid'
require_relative 'expectations/version'
require_relative 'expectations/unimplemented'
require_relative 'expectations/invalid_args'
require_relative 'expectations/match'
require_relative 'expectations/value'

# Factory to register framework expectations.
class Expectations
  extend Toolcase::Registry

  def self.define_handler_method(handler)
    define_singleton_method(handler.name.downcase.to_sym) { handler.new }
  end

  class << self
    private :define_handler_method
  end

  def self.add(handler)
    register(handler)
    define_handler_method(handler)
  end

  default Invalid

  add Version
  add Unimplemented
  add InvalidArgs
  add Match
  add Value

  def self.determine_by(config)
    find_by { |handler| handler.accept?(config) }.new(config)
  end
end
