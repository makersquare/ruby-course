
class TM::Task
  attr_reader :task_id, :description, :priority, :project_id, :creation_date
  attr_accessor :status

  @@task_id = 0

  def initialize(project_id, description, priority=3)
    @@task_id += 1
    @task_id = @@task_id
    @description = description
    @priority = priority
    @project_id = project_id
    @status = "incomplete"
    @creation_date = Time.now
  end

  def self.task_id
    @@task_id
  end

  # def ==(other_task)
  #   self.id == other_task.id
  # end

end
