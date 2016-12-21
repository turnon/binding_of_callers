require 'test_helper'
require 'mock/u'
require 'pp'

class BindingOfCallersTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BindingOfCallers::VERSION
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
      pp binds[n]
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
