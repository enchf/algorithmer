# frozen_string_literal: true

module Utils
  def to_camelcase(str)
    str.chars.slice_before { |ch| /[A-Z]/.match?(ch) }.map(&:join).map(&:downcase).join('_')
  end

  def ensure_present(config, property, object)
    raise "Missing config property #{property} in #{object}" unless config.key?(property)
  end
end
