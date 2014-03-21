class TM::Employee
  attr_reader :name, :id

  @@counter = 0

  def initialize(name)
    @name = name
    @@counter += 1
    @id = @@counter
  end

end