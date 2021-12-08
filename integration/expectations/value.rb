# frozen_string_literal: true

require_relative 'base'

class Value < Base
  def self.accept?(config)
    config.is_a?(String) || config.is_a?(Numeric) || (hash?(config) && key?(config, 'value'))
  end

  attr_reader :expected_value

  def initialize(config)
    @expected_value = hash?(config) ? config['match'] : config
  end

  def match?(value)
    expected_value == value
  end

  def expected
    expected_value
  end
end
