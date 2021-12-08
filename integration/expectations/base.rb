# frozen_string_literal: true

# Base class for all framework expectations.
class Base
  # Validation helpers
  module Helpers
    def hash?(value)
      value.is_a?(Hash)
    end

    def key?(config, key)
      config.key?(key)
    end
  end

  include Helpers
  extend Helpers

  def initialize(_); end

  def valid?
    true
  end
end
