require "binding_of_callers/version"
require 'binding_of_callers/revealed'
require 'binding_of_caller'

class Binding

  def of_callers
    n = 1
    caller_arr = caller
    top_caller_index = caller_arr.count - 1
    callers_vars = []
    while n < top_caller_index
      _binding = binding.of_caller(n)
      src_location = caller_arr[n - 1]
      revealed = BindingOfCallers::Revealed.new _binding, src_location 
      callers_vars << revealed
      n = n.succ
    end
    callers_vars
  rescue RuntimeError
    callers_vars
  end

end
