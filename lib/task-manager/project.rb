
class TM::Project

  @@id_count = 0
  attr_reader :name, :id

  def initialize(name)


    @name = name
    @@id_count += 1
    @id = @@id_count

  end

  def self.reset_class_variables
    @@id_count = 0
  end


end
