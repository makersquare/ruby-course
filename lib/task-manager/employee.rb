class TM::Employee
  attr_accessor :name
  attr_reader :id

  @@counter = 0

  def initialize(name)
    @name = name
    @@counter += 1
    @id = @@counter
  end

end