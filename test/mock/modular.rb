require 'binding_of_caller'

module Modular
  def self.invoke
    SubClassOfBasic.invoke
  end

  class ClassInModule
    def initialize
      @class_in_module = '@class_in_module'
    end

    def invoke
      class_in_module = 'class_in_module'
      binding.of_callers
    end
  end
end

class TopClass
  def initialize
    @top_class = '@top_class'
    @class_in_module = Modular::ClassInModule.new
  end

  def invoke
    top_class = 'top_class'
    @class_in_module.invoke
  end
end

class SubClassOfBasic < BasicObject
  def initialize
    @sub_class_of_basic = '@sub_class_of_basic'
    @top_class = ::TopClass.new
  end

  def invoke
    @top_class.invoke
  end

  def self.invoke
    new.invoke
  end
end
