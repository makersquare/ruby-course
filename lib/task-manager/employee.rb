class TM::Employee
  attr_reader :name, :id, :id_counter
  @@id_counter = 1
  def initialize(name)
    @name = name
    @id = @@id_counter
    @@id_counter += 1
  end

end
