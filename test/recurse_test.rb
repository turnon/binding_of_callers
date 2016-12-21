require 'test_helper'
require 'pp'

class RecurseTest < Minitest::Test
  class SeqSum
    def calc n, sum=0
      return sum, binding.of_callers! if n == 0
      calc(n - 1, n + sum)
    end
  end

  def test_it_does_something_useful
    puts "---------------> get binding from recursive"
    s = SeqSum.new
    result, binds = s.calc 10
    pp binds[0..10].map &:lv
  end

end
