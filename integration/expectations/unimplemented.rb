# frozen_string_literal: true

require_relative 'match'

# Match expectation that search for the unimplemented warning string.
class Unimplemented < Match
  ID = 'UNIMPLEMENTED'
  MATCH_STRING = "^Action '([a-z]+)' is not defined(.*)$"

  def self.accept?(config)
    ID == config
  end

  def match_string
    MATCH_STRING
  end
end
