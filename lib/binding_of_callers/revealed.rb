require 'binding_of_callers/reveal'

module BindingOfCallers
  class Revealed

    include Reveal

    def initialize _binding
      @_binding = _binding
    end

  end
end
