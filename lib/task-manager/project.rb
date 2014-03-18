
class TM::Project
@@id = 0
attr_reader :id, :description, :priority_number, :name
attr_accessor :id
  def initialize(name,description, priority_number)
    @@id += 1
    @name = name
    @description = description
    @priority_number = priority_number
  end

   def self.id
    @@id
  end

end
