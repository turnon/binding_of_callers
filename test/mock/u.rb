require 'mock/a'

module U
  def self.invoke
    A.new.invoke
  end
end
