# frozen_string_literal: true

require "test_helper"

class ProblemsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Problems::VERSION
  end

  def test_gem_is_executable
    refute_includes `problems`, 'command not found'
  end
end
