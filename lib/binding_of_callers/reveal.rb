module BindingOfCallers
  module Reveal

    attr_accessor :src_location

    def _binding
      @_binding or self
    end

    def inspect
      file, line = file_line
      "#<#{self.class}:#{object_id} #{klass}#{call_symbol}#{frame_env} #{file}:#{line}>"
    end

    def iv
      _binding.eval <<-EOS
        instance_variables.each_with_object({}) do |iv_name, vars|
          vars[iv_name] = instance_variable_get(iv_name)
        end
      EOS
    end

    def lv
      _binding.local_variables.each_with_object({}) do |iv_name, vars|
        vars[iv_name] = _binding.local_variable_get iv_name
      end
    end

    def klass
      @klass ||= _binding.eval(singleton_method? ? 'self' : 'self.class')
    end

    def singleton_method?
      return @sm if instance_variable_defined? :@sm
      class_name = _binding.eval 'self.class.name'
      @sm = (class_name == 'Module' or class_name == 'Class')
    end

    def call_symbol
      @call_sym ||= singleton_method? ? '.' : '#'
    end

    def file_line
      file, line, _ = src_location.split(/:/)
      [file, line]
    end

    def frame_env
      _binding.frame_description
    end

    def env_type
      _binding.frame_type
    end
  end
end
