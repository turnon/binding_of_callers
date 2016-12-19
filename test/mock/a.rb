require 'mock/b'

class A
  def initialize
    @a = '@a'
    @b = B::SubB.new
  end

  def invoke
    a = 'a'
    @b.invoke
  end
end
