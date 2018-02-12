module BindingOfCallers
  module Reveal

    Klass = Kernel.instance_method(:class)

    def _binding
      instance_variable_defined?(:@_binding) ? @_binding : self
    end

    def inspect
      "#<#{self.class}:#{object_id} #{file}:#{line} #{klass}#{call_symbol}#{frame_env}>"
    end

    def iv *args
      case args.count
      when 0
        all_iv
      when 1
        the_iv args[0]
      when 2
        set_iv(*args)
      end
    end

    def lv *args
      case args.count
      when 0
        all_lv
      when 1
        the_lv args[0]
      when 2
        set_lv(*args)
      end
    end

    def klass
      return @klass if instance_variable_defined? :@klass
      determine_klass
      @klass
    end

    def singleton_method?
      return @sm if instance_variable_defined? :@sm
      determine_klass
      @sm
    end

    def call_symbol
      @call_sym ||= singleton_method? ? '.' : '#'
    end

    def file
      _binding.eval('__FILE__')
    end

    def line
      _binding.eval('__LINE__')
    end

    def frame_env
      _binding.frame_description
    end

    def env_type
      _binding.frame_type
    end

    private

    def determine_klass
      itself = binding_self
      binding_class = (Object === itself ? itself.class : Klass.bind(itself).call)
      class_name = binding_class.name
      if class_name == 'Module' || class_name == 'Class'
        @sm = true
        @klass = itself
      else
        @sm = false
        @klass = binding_class
      end
    end

    def all_iv
      _binding.eval <<-EOS
        instance_variables.each_with_object({}) do |iv_name, vars|
          vars[iv_name] = instance_variable_get(iv_name)
        end
      EOS
    end

    def the_iv name
      binding_self.instance_variable_get name
    end

    def set_iv name, value
      binding_self.instance_variable_set name, value
    end

    def binding_self
      _binding.eval "instance_eval('self')"
    end

    def all_lv
      _binding.send(:local_variables).each_with_object({}) do |lv_name, vars|
        vars[lv_name] = the_lv lv_name
      end
    end

    def the_lv name
      _binding.local_variable_get name
    end

    def set_lv name, value
      _binding.local_variable_set name, value
    end
  end
end
