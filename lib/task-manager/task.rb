
class TM::Task
    attr_reader :name, :task_id, :description, :project_id
    @@task_counter = 0
  def initialize(project_id, description)
    @name = name
    @@task_counter += 1
    @task_id = @@task_counter
    @description = description
    @project_id = project_id
  end
end
