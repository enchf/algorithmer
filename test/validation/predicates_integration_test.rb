# frozen_string_literal: true

require 'test_helper'

class PredicatesIntegrationTest < Minitest::Test
  def test_reserved_word
    instance = validator_instance { reserved_word :word }

    assert instance.valid?(:word)
    refute instance.valid?(:sword)
  end

  def test_format
    instance = validator_instance { format(/^[A-Z]+$/) }

    assert instance.valid?('UPPER')
    refute instance.valid?('Camel')
    refute instance.valid?('snake')
  end

  def test_non_reserved_word
    validator_instance { reserved_word :test_word }
    instance = validator_instance { non_reserved_word }

    assert instance.valid?('a_word')
    refute instance.valid?('test_word')
    refute instance.valid?(:test_word)
  end

  def test_any
    instance = validator_instance do
      any do
        reserved_word :word
        format(/^[A-Z]+$/)
      end
    end

    [:word, 'UPPER'].each { |value| assert instance.valid?(value) }
    [:sword, 'Camel', 'snake'].each { |value| refute instance.valid?(value) }
  end

  def test_all
    instance = validator_instance do
      all do
        custom(&:positive?)
        custom { |val| val < 10 }
      end
    end

    (1..9).each { |num| assert instance.valid?(num) }
    [-1, 0, 10, 11].each { |num| refute instance.valid?(num) }
  end

  def test_empty_args
    instance = validator_instance { empty_args }
    assert instance.valid?
    refute instance.valid?(1)
    refute instance.valid?(1, 2, 3)
  end

  def test_optional
    instance = validator_instance do
      optional { reserved_word :word }
    end

    assert instance.valid?
    assert instance.valid?(:word)
    refute instance.valid?(:sword)
  end

  def validator
    Problems::Validator
  end

  def validator_instance(&block)
    validator.new.evaluate(&block)
  end
end
