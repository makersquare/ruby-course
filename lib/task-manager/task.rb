
class TM::Task
  attr_accessor :description, :priority_number, :project_id, :name, :complete, :completed


  def initialize(name, description, priority_number)
    @name = name
    @description = description
    @priority_number = priority_number
    @completed = false
  end

  def complete
    @completed = true
  end

end

