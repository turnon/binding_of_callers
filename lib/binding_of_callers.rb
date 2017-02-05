require "binding_of_callers/version"
require 'binding_of_callers/revealed'
require 'binding_of_caller'

class Binding

  def of_callers
    enhance do |bi|
      BindingOfCallers::Revealed.new bi
    end
  end

  def of_callers!
    enhance do |bi|
      bi.extend BindingOfCallers::Reveal
    end
  end

  private

  def enhance &enhance
    collected.map(&enhance)
  end

  def collected
    n = 3
    bis = []
    while n < frame_count
      bis << of_caller(n)
      n = n.succ
    end
    bis
  end

end
