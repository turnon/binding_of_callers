require 'test_helper'
require 'mock/u'
require 'pp'

class BindingOfCallersTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BindingOfCallers::VERSION
  end

  def test_it_does_something_useful
    binds = U.invoke
    (0..3).each do |n|
      puts
      pp binds[n]
    end
  end
end
