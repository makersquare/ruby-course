
class TM::Project
  @@id_counter = 0
  attr_reader :name
  attr_accessor :id_counter
  def initialize(name)
    @name = name
    @@id_counter +=1
  end

  def id_counter
    @@id_counter
  end
end
