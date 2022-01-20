# frozen_string_literal: true

require 'test_helper'
require 'problems/components/arguments'

class ArgumentsTest < Minitest::Test
  def test_reserved_word
    single_validator_test %w[this], %w[other] do
      reserved_word :this
    end
  end

  def test_match
    single_validator_test %w[AlphaNumeric123], %w[With_2_SpecialChars] do
      format(/^[A-Za-z0-9]+$/)
    end
  end

  def test_multiple_arguments
    arguments = instantiate do
      reserved_word :if
      format(/^[A-Za-z]+$/)
      reserved_word :do
    end
    assert 3, arguments.size
  end

  private

  def instantiate(&block)
    tested_class.new(&block)
  end

  def tested_class
    Problems::Arguments
  end

  def single_validator_test(valids, invalids, &block)
    arguments = instantiate(&block)
    validator = arguments.validators.first
    valids.each { |value| assert validator.valid?(value) }
    invalids.each { |value| refute validator.valid?(value) }
  end
end
