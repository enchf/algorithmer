# frozen_string_literal: true

require_relative 'base'

# Abstraction for an invalid expectation configuration.
class Invalid < Base
  def valid?
    false
  end

  def match?(_)
    false
  end
end
