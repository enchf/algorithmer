# frozen_string_literal: true

require_relative 'base'

class Match < Base
  def self.accept?(config)
    hash?(config) && key?(config, 'match')
  end

  attr_reader :match_string

  def initialize(config)
    @match_string = config['match']
  end

  def match?(value)
    value.match?(match_string)
  end

  def expected
    match_string
  end
end
