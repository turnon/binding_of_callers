require 'mock/c'

module B
  class SubB
    def initialize
      @b = '@b'
      @c = C.new
    end

    def invoke
      b = 'b'
      @c.invoke
    end
  end
end
