# frozen_string_literal: true

require 'test_helper'

class PredicatesIntegrationTest < Minitest::Test
  def test_reserved_word
    instance = validator.new.evaluate { reserved_word :word }

    assert instance.valid?(:word)
    refute instance.valid?(:sword)
  end

  def test_format
    instance = validator.new.evaluate { format(/^[A-Z]+$/) }

    assert instance.valid?('UPPER')
    refute instance.valid?('Camel')
    refute instance.valid?('snake')
  end

  def test_any
    instance = validator.new.evaluate do
      any do
        reserved_word :word
        format(/^[A-Z]+$/)
      end
    end

    [:word, 'UPPER'].each { |value| assert instance.valid?(value) }
    [:sword, 'Camel', 'snake'].each { |value| refute instance.valid?(value) }
  end

  def test_optional
    instance = validator.new.evaluate do
      optional { reserved_word :word }
    end

    assert instance.valid?
    assert instance.valid?(:word)
    refute instance.valid?(:sword)
  end

  def validator
    Problems::Validator
  end
end
