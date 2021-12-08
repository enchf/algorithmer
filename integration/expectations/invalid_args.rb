# frozen_string_literal: true

require_relative 'match'

# Match an invalid arguments execution.
class InvalidArgs < Match
  ID = 'INVALID_ARGS'
  MATCH_STRING = '^Arguments passed do not represent a valid object: (.*)$'

  def self.accept?(config)
    ID == config
  end

  def match_string
    MATCH_STRING
  end
end
