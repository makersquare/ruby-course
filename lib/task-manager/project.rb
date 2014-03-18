
class TM::Project
attr_reader :name, :id

  @@id_counter = 0

  def initialize(name)
    @name = name
    @@id_counter += 1
    @id = @@id_counter
  end

end

