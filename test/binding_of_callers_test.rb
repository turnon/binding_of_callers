require 'test_helper'
require 'mock/modular'

class BindingOfCallersTest < Minitest::Test

  def setup
    @binds = Modular.invoke.select{ |b| b.file =~ /binding_of_callers/}
  end

  def test_that_it_has_a_version_number
    refute_nil ::BindingOfCallers::VERSION
  end

  def test_puts
    pp @binds.map{ |b| [b.line, b.file] }
  end

  def test_iv
    b = at_line 28
    refute_nil b
    assert_equal '@top_class', b.iv(:@top_class)
  end

  def test_lv
    b = at_line 15
    refute_nil b
    assert_equal ({class_in_module: 'class_in_module'}), b.lv
  end

  def test_klass_of_singleton_method_call
    b = at_line 5
    refute_nil b
    assert_equal Modular, b.klass
  end

  def test_klass_of_instance_method_call
    b = at_line 15
    refute_nil b
    assert_equal Modular::ClassInModule, b.klass
  end

  def test_singleton_method
    b = at_line 5
    refute_nil b
    assert b.singleton_method?
    b = at_line 15
    refute_nil b
    refute b.singleton_method?
  end

  def test_klass_of_basic_object_singleton_method_call
    b = at_line 43
    refute_nil b
    assert_equal SubClassOfBasic, b.klass
  end

  def test_klass_of_basic_object_instance_method_call
    b = at_line 39
    refute_nil b
    assert_equal SubClassOfBasic, b.klass
  end

  def test_basic_object_singleton_method
    b = at_line 43
    refute_nil b
    assert b.singleton_method?
    b = at_line 39
    refute_nil b
    refute b.singleton_method?
  end

  private

  def at_line n
    @binds.find{ |b| b.line == n }
  end

end
