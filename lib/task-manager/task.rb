
class TM::Task
  def initialize(project_id, description, priority_number)
    attr_reader :project_id, :description, :priority_number

    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @status = "incomplete"
    @date = get.Time
    @completed_tasks = []
    @incompleted_tasks = []
  end

  def completed_task
    @staus = "complete"
    @completed_tasks << @project_id
  end



end
