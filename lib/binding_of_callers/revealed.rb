require 'binding_of_callers/reveal'

module BindingOfCallers
  class Revealed

    include Reveal

    attr_reader :_binding, :src_location

    def initialize _binding, src_loc
      @_binding = _binding
      @src_location = src_loc
    end

  end
end
