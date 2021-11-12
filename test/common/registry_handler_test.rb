# frozen_string_literal: true

require 'test_helper'
require 'problems/common/registry_handler'

class RegistryHandlerTest < Minitest::Test
  CLASS_NAME_DEMODULIZED = proc { |clazz| clazz.name.split('::').last }

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
    key(&:key)
    default Foo
    register Bar
    register Baz
  end

  class B
    extend Common::RegistryHandler
    key(&:key)
    register Boo
  end

  class C
    extend Common::RegistryHandler
    key(&CLASS_NAME_DEMODULIZED)
    register Baz
    register Boo
    resolver { |name| registry[name].new }
  end

  class D
    extend Common::RegistryHandler
    key { |clazz| clazz.name.upcase }
    resolver { |name| registry[name].new }
    default Foo
  end

  def test_methods_available
    assert_respond_to A, :registry
    refute_respond_to A.new, :registry
  end

  def test_registry_added
    assert_equal Bar, A.registry[:bar]
    assert_equal Baz, A.registry[:baz]
  end

  def test_registry_default
    assert_equal Foo, A.registry[:unknown]
    assert_equal Foo, A.registry[nil]
  end

  def test_no_default
    assert_nil B.registry[:unknown]
  end

  def test_independent_registries
    refute_equal A.registry[:boo], B.registry[:boo]
    assert_nil   B.registry[:bar]
  end

  def test_resolve_function
    assert_instance_of Baz, C.resolve('Baz')
    assert_instance_of Foo, D.resolve('Any')
  end

  def test_list_of_all_registries
    assert_equal [Bar, Baz], A.all_registries
  end
end
