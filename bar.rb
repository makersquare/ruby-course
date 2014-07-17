require 'time' # you're gonna need it

class Bar

  attr_reader :name
  
  def initialize(name="The Irish Yodel")
    @name = name
  end
end
