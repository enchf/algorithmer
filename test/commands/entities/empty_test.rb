# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/entities/empty'

class EmptyTest < Minitest::Test
  def test_refuted_args
    refute tested_class.accept?(nil, 'a', nil)
    refute tested_class.accept?('', 'a', '')
    refute tested_class.accept?('a', 'b')
    refute tested_class.accept?('1')
  end

  def test_accepted_args
    assert tested_class.accept?
    assert tested_class.accept?(nil)
    assert tested_class.accept?(nil, nil)
    assert tested_class.accept?('')
    assert tested_class.accept?('', '')
  end

  def tested_class
    ::Commands::Empty
  end
end
