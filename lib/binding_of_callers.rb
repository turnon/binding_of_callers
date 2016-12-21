require "binding_of_callers/version"
require 'binding_of_callers/revealed'
require 'binding_of_caller'

class Binding

  def of_callers
    enhance do |bi, loc|
      BindingOfCallers::Revealed.new bi, loc
    end
  end

  def of_callers!
    enhance do |bi, loc|
      bi.extend BindingOfCallers::Reveal
      bi.src_location = loc
      bi
    end
  end

  private

  def enhance &enhance
    collected.map &enhance
  end

  def collected
    n = 3
    bis = []
    while n < frame_count
      bis << of_caller(n)
      n = n.succ
    end
    call_st = caller
    call_st.shift(2)
    bis.zip call_st
  end

end
