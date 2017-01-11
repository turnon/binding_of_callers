require 'test_helper'
require 'mock/u'

class BindingOfCallersTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BindingOfCallers::VERSION
  end

  def test_convenient_instance_variable
    binds = U.invoke
    assert_equal '@b', binds[1].iv(:@b)
    binds[1].iv :@b, 'b'
    assert_equal 'b', binds[1].iv(:@b)
  end

  def test_convenient_local_variable
    binds = U.invoke
    assert_equal 'a', binds[2].lv(:a)
    binds[2].lv :a, 123
    assert_equal 123, binds[2].lv(:a)
  end

  def test_it_does_something_useful
    methods.select do |m|
      m =~ /^check/
    end.each do |m|
      puts "\n\n---------------> #{m}"
      send m
    end
  end

  def output
    binds = U.invoke
    (0..3).each do |n|
      b = binds[n]
      puts "#{b.inspect} #{b.iv} #{b.lv}"
    end
  end

  def check_original_defined_method
    output
  end

  def check_define_method
    C.send :define_method, :invoke do
      c = 'c'
      binding.of_callers
    end
    output
  end

  def check_class_eval_define_method
    C.class_eval do
      def invoke
        c = 'c'
        binding.of_callers
      end
    end
    output
  end

  def check_instance_eval_define_method
    C.instance_eval do
      define_method :invoke do
        c = 'c'
        binding.of_callers
      end
    end
    output
  end
end
