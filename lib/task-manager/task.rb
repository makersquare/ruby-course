
class TM::Task
  attr_accessor :task_id, :description, :priority_number


  def initialize(description, priority_number)
    @description = description
    @priority_number = priority_number
  end

end
