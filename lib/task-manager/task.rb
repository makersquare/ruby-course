
class TM::Task
  attr_accessor :description, :priority_number, :project_id, :name, :complete, :completed, :creation_date


  def initialize(name, description, priority_number)
    @name = name
    @description = description
    @priority_number = priority_number
    @completed = false
    @creation_date = Time.now
  end

  def complete
    @completed = true
  end

end

