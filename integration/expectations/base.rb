# frozen_string_literal: true

class Base
  def initialize(_); end

  def valid?
    true
  end

  # Helpers

  def hash?(value)
    value.is_a?(Hash)
  end

  def key?(config, key)
    config.key?(key)
  end
end
