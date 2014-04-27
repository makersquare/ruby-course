
class TM::Project
  attr_reader :id
  @@id_counter = 0

  def initialize(name)
    @name = name
    @id = @@id_counter
    @@id_counter += 1
  end

end
