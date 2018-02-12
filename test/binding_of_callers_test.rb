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
    b = at_line 45
    refute_nil b
    assert_equal SubClassOfBasic, b.klass
  end

  def test_klass_of_basic_object_instance_method_call
    b = at_line 40
    refute_nil b
    assert_equal SubClassOfBasic, b.klass
  end

  def test_basic_object_singleton_method
    b = at_line 45
    refute_nil b
    assert b.singleton_method?
    b = at_line 40
    refute_nil b
    refute b.singleton_method?
  end

  def test_all_iv_in_basic_object
    b = at_line 40
    refute_nil b
    assert_equal [:@sub_class_of_basic, :@top_class], b.iv.keys
  end

  def test_the_iv_in_basic_object
    b = at_line 40
    refute_nil b
    assert_equal '@sub_class_of_basic', b.iv(:@sub_class_of_basic)
  end

  def test_set_iv_in_basic_object
    b = at_line 40
    refute_nil b
    b.iv(:@sub_class_of_basic, 123)
    assert_equal 123, b.iv(:@sub_class_of_basic)
  end

  private

  def at_line n
    @binds.find{ |b| b.line == n }
  end

end
