require 'binding_of_caller'

module Modular
  def self.invoke
    SubClassOfBasic.invoke
  end

  class ClassInModule

    attr_reader :class_in_module

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

  attr_reader :top_class, :return_local

  def initialize
    @top_class = '@top_class'
    Thread.current[:class_in_module] = @class_in_module = Modular::ClassInModule.new
  end

  def invoke
    top_class = 'top_class'
    @return_local = -> { top_class }
    @class_in_module.invoke
  end
end

class SubClassOfBasic < BasicObject

  attr_reader :sub_class_of_basic, :return_local

  def initialize
    @sub_class_of_basic = '@sub_class_of_basic'
    ::Thread.current[:top_class] = @top_class = ::TopClass.new
  end

  def invoke
    sub_class_of_basic = 'sub_class_of_basic'
    @return_local = -> { sub_class_of_basic }
    @top_class.invoke
  end

  def self.invoke
    sub_class_of_basic = 'sub_class_of_basic'
    (::Thread.current[:sub_class_of_basic] = new).invoke
  end
end
