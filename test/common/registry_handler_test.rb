# frozen_string_literal: true

require 'test_helper'
require 'problems/common/registry_handler'

class RegistryHandlerTest < Minitest::Test
  class Foo
    def self.key() :foo end
  end

  class Bar
    def self.key() :bar end
  end

  class Baz
    def self.key() :baz end
  end

  class Boo
    def self.key() :boo end
  end

  class A
    extend Common::RegistryHandler
    default Foo
    register Bar
    register Baz
  end

  class B
    extend Common::RegistryHandler
    register Boo
  end

  def test_methods_available
    assert_respond_to A, :actions
    refute_respond_to A.new, :actions
  end

  def test_registry_added
    assert_equal A.actions[:bar], Bar
    assert_equal A.actions[:baz], Baz
  end

  def test_registry_default
    assert_equal A.actions[:unknown], Foo
    assert_equal A.actions[nil],      Foo
  end

  def test_no_default
    assert_nil B.actions[:unknown]
  end

  def test_independent_registries
    refute_equal A.actions[:boo], B.actions[:boo]
    refute B.actions[:bar]
  end
end
