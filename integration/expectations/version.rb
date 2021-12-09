# frozen_string_literal: true

require 'problems/version'
require_relative 'value'

# Value expectation that expects gem version value.
class Version < Value
  ID = 'VERSION'

  def self.accept?(config)
    ID == config
  end

  def expected_value
    ::Problems::VERSION
  end
end
