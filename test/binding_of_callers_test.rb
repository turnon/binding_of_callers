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

  def test_get_iv
    b = at_line 35
    refute_nil b
    assert_equal '@top_class', b.iv(:@top_class)
  end

  def test_set_iv
    b = at_line 18
    refute_nil b
    b.iv :@class_in_module, 456
    assert_equal 456, Thread.current[:class_in_module].class_in_module
  end

  def test_lv
    b = at_line 18
    refute_nil b
    assert_equal ({class_in_module: 'class_in_module'}), b.lv
  end

  def test_get_lv
    b = at_line 18
    refute_nil b
    assert_equal 'class_in_module', b.lv(:class_in_module)
  end

  def test_set_lv
    b = at_line 35
    refute_nil b
    b.lv :top_class, 789
    assert_equal 789, Thread.current[:top_class].return_local.call
  end

  def test_klass_of_singleton_method_call
    b = at_line 5
    refute_nil b
    assert_equal Modular, b.klass
  end

  def test_klass_of_instance_method_call
    b = at_line 18
    refute_nil b
    assert_equal Modular::ClassInModule, b.klass
  end

  def test_singleton_method
    b = at_line 5
    refute_nil b
    assert b.singleton_method?
    b = at_line 18
    refute_nil b
    refute b.singleton_method?
  end

  def test_klass_of_basic_object_singleton_method_call
    b = at_line 56
    refute_nil b
    assert_equal SubClassOfBasic, b.klass
  end

  def test_klass_of_basic_object_instance_method_call
    b = at_line 51
    refute_nil b
    assert_equal SubClassOfBasic, b.klass
  end

  def test_basic_object_singleton_method
    b = at_line 56
    refute_nil b
    assert b.singleton_method?
    b = at_line 51
    refute_nil b
    refute b.singleton_method?
  end

  def test_all_iv_in_basic_object
    b = at_line 51
    refute_nil b
    assert_equal [:@sub_class_of_basic, :@top_class, :@return_local], b.iv.keys
  end

  def test_get_iv_in_basic_object
    b = at_line 51
    refute_nil b
    assert_equal '@sub_class_of_basic', b.iv(:@sub_class_of_basic)
  end

  def test_set_iv_in_basic_object
    b = at_line 51
    refute_nil b
    b.iv(:@sub_class_of_basic, 123)
    assert_equal 123, Thread.current[:sub_class_of_basic].sub_class_of_basic
  end

  def test_lv_in_basic_object
    b = at_line 56
    refute_nil b
    assert_equal ({sub_class_of_basic: 'sub_class_of_basic'}), b.lv
  end

  def test_get_lv_in_basic_object
    b = at_line 56
    refute_nil b
    assert_equal 'sub_class_of_basic', b.lv(:sub_class_of_basic)
  end

  def test_set_lv_in_basic_object
    b = at_line 51
    refute_nil b
    b.lv(:sub_class_of_basic, 678)
    assert_equal 678, Thread.current[:sub_class_of_basic].return_local.call
  end

  private

  def at_line n
    @binds.find{ |b| b.line == n }
  end

end
