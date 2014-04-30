
class TM::Task
  attr_accessor :description, :priority_number, :project_id, :name


  def initialize(name, description, priority_number)
    @name = name
    @description = description
    @priority_number = priority_number
  end

end

