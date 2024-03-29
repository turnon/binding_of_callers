require "binding_of_callers/version"
require 'binding_of_callers/revealed'
require 'binding_of_caller'

class Binding

  def of_callers(fc = frame_count)
    enhance(fc) do |bi|
      BindingOfCallers::Revealed.new bi
    end
  end

  def of_callers!(fc = frame_count)
    enhance(fc) do |bi|
      bi.extend BindingOfCallers::Reveal
    end
  end

  def partial_callers(limit)
    _callers = callers
    limit = _callers.size + limit if limit < 0
    _callers[1, limit].map!{ |c| BindingOfCallers::Revealed.new(c) }
  end

  private

  def enhance(fc, &enhance)
    collected(fc).map(&enhance)
  end

  def collected(fc)
    n = 3
    bis = []
    while n < fc
      bis << of_caller(n)
      n = n.succ
    end
    bis
  end

end
