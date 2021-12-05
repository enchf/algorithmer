# frozen_string_literal: true

require 'yaml'
require 'test_helper'
require 'problems/commands/entities/base'

class CommandsTest < Minitest::Test
  SUITES_PATH = 'test/integration/suites'

  def setup
    @suites = suites.map(&method(:load_suite))
  end

  def test_suites
    @suites.each(&method(:test_suite))
    assert true
  end

  private

  def suites
    Dir.children(suites_path).map { |file| File.join(suites_path, file) }
  end

  def load_suite(suite)
    YAML.load_file(suite)
  end

  def suites_path
    File.join(Dir.getwd, SUITES_PATH)
  end

  def to_camelcase(str)
    str.chars.slice_before { |ch| /[A-Z]/.match?(ch) }.map(&:join).map(&:downcase).join('_')
  end

  def test_suite(suite); end
end
