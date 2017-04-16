require 'binding_of_callers'
require 'pry'

class Binding
  def pry(object=nil, hash={})
    bs = of_callers!.tap &:shift
    bs_indexed = bs.each_with_object({}){|b, h| h[h.keys.count] = b}
    Pry.hooks.add_hook :when_started, "original_binding_stack_#{object_id}" do |target, options, pry_self|
      pry_self.inject_local :_bs_, bs, pry_self.current_binding
      pry_self.inject_local :_bsi_, bs_indexed, pry_self.current_binding
    end
    Pry.start self
  end
end
