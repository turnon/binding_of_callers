require 'binding_of_caller'

class C
  def initialize
    @c = '@c'
  end

  def invoke
    c = 'c'
    binding.of_callers
  end
end
