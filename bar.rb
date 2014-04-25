require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :array

  def initialize(name)
    @name = name
  end

  def menu_items
    @array = []
  end
end
