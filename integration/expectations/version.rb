# frozen_string_literal: true

require 'problems/version'
require_relative 'value'

# Value expectation that expects gem version value.
class Version < Value
  def self.accept?(config)
    config == 'VERSION'
  end

  def expected_value
    ::Problems::VERSION
  end
end
