
class TM::Task
  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @complete = false
  end

  def complete?
    @complete
  end

  def mark_complete
    @complete = true
  end
end
