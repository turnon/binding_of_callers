require 'binding_of_callers'
require 'pry'

class Binding
  def pry(object=nil, hash={})
    bs = of_callers!.tap &:shift
    Pry.hooks.add_hook :when_started, "original_binding_stack_#{object_id}" do |target, options, pry_self|
      pry_self.inject_local :_bs_, bs, pry_self.current_binding
    end
    Pry.start self
  end
end
