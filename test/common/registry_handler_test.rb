# frozen_string_literal: true

require 'test_helper'
require 'problems/common/registry_handler'

class RegistryHandlerTest < Minitest::Test
  class Foo; end
  class Bar; end
  class Baz; end
  class Boo; end
  class Woo; end

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

  class C
    extend Common::RegistryHandler
    register Baz
    register Boo
  end

  class D
    extend Common::RegistryHandler
    default Foo
    register Boo
    register Baz
  end

  class E < A
    register Boo
  end

  class F
    extend Common::RegistryHandler
    register { |*args| args.nil? }
    register { |*args| args.empty? }
  end

  class G < E
    register Woo
  end

  def test_methods_available
    %i[registries include? default register find_by].each do |method|
      assert_respond_to A, method, "Method: #{method} on class"
      refute_respond_to A.new, method, "Method: #{method} on instance"
    end
  end

  def test_registry_added
    assert A.include?(Bar)
    assert A.include?(Baz)
    refute A.include?(Boo)
  end

  def test_registry_default
    assert_equal Foo, A.default
  end

  def test_no_default
    assert_nil B.default
  end

  def test_independent_registries
    refute_equal A.registries, B.registries
  end

  def test_find_by
    assert_equal(Baz, C.find_by { |handler| handler.name.end_with?('Baz') })
  end

  def test_find_by_default
    assert_equal(Foo, D.find_by { |handler| handler.name == 'Bar' })
  end

  def test_list_of_all_registries
    assert_equal [Bar, Baz], A.registries
  end

  def test_registries_available_in_subclass
    assert_equal A.default, E.default
    assert_equal [Bar, Baz, Boo], E.registries
    assert_equal(Foo, E.find_by { |handler| handler.name == 'Taz' })
  end

  def test_register_accepts_blocks
    F.registries.all? do |block|
      assert_respond_to block, :call
    end
    refute F.registries.first.call
    assert F.registries.last.call
  end

  def test_registries_available_in_deeper_inheritance
    assert_equal A.default, G.default
    assert_equal E.default, G.default
    assert_equal [Bar, Baz, Boo, Woo], G.registries
    assert_equal(Foo, G.find_by { |handler| handler.name == 'Taz' })
    assert_equal(Woo, G.find_by { |handler| handler.name.end_with?('Woo') })
    assert_equal(Boo, G.find_by { |handler| handler.name.end_with?('Boo') })
  end
end
