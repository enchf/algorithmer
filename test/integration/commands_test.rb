# frozen_string_literal: true

require 'yaml'
require 'problems/commands/entities/base'

require_relative 'suite'

class CommandsTest
  SUITES_PATH = 'test/integration/suites'

  def initialize
    @suites = suites.map(&method(:load_suite))
  end

  def run
    @suites.each(&:test)
  end

  private

  def suites
    Dir.children(suites_path).map { |file| File.join(suites_path, file) }
  end

  def load_suite(suite)
    Suite.new(YAML.load_file(suite))
  end

  def suites_path
    File.join(Dir.getwd, SUITES_PATH)
  end

  def to_camelcase(str)
    str.chars.slice_before { |ch| /[A-Z]/.match?(ch) }.map(&:join).map(&:downcase).join('_')
  end
end

CommandsTest.new.run
