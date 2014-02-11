require 'time' # you're gonna need it

class Bar
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end
