class TM::Task
  attr_accessor :project_id, :description, :priority
  attr_reader :task_id
  @@current_id = 1

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @task_id = @@current_id
    @@current_id = @@current_id + 1
  end

end
