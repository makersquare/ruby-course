
class TM::Task
  attr_reader :id
  @@counter = 0

  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number

    @task_id = @@counter
    @@counter += 1
    @creation_date = Date.today
  end
end
