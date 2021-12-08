# frozen_string_literal: true

require_relative 'base'

class Invalid < Base
  def valid?
    false
  end

  def match?(_)
    false
  end
end
