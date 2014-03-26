class TM::Employee

  attr_reader :id
  attr_accessor :name

  @@counter = 0

  def initialize(name)
    @name = name
    @id = @@counter+=1
  end


end
