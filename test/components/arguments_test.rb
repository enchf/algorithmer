# frozen_string_literal: true

require 'test_helper'
require 'problems/components/arguments'

class ArgumentsTest < Minitest::Test
  def test_keyword
    arguments = instantiate do
      keyword :this
    end

    assert 1, arguments.size
    assert arguments.validators.first.valid?('this')
    refute arguments.validators.first.valid?('other')
  end

  private

  def instantiate(&block)
    tested_class.new(&block)
  end

  def tested_class
    Problems::Arguments
  end
end
