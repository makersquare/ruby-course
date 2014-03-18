
class TM::Project
@@id = 0
attr_reader :id, :description, :priority_number
attr_accessor :id
  def initialize(description, priority_number)
    @@id += 1
    @description = description
    @priority_number = priority_number
  end

   def self.id
    @@id
  end

end
