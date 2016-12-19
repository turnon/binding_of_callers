module BindingOfCallers
  class Revealed

    attr_reader :_binding, :src_location

    def initialize _binding, src_loc
      @_binding = _binding
      @src_location = src_loc
    end

    def inspect
      file, line, method = file_line_method
      {[klass, call_symbol, method, file, line] => [iv, lv]}
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

    def file_line_method
      file, line, method = src_location.split(/:/)
      [file, line, method.slice(4..-2)]
    end
  end
end
