
class TM::Task
  attr_reader :task_id, :project_id, :creation_time, :description, :priority
  attr_accessor :status
  @@counter = 0
  @@tasks_list = []

  def initialize project_id, description, priority
    @project_id = project_id
    @description = description
    @priority = priority
    @task_id = @@counter
    @@counter += 1
    @creation_time = Time.now
    @status = :incomplete
    @@tasks_list << self
  end

  def self.tasks_list
    @@tasks_list
  end

  def self.mark_complete(task_id)
    task_id = task_id.to_i
    task = @@tasks_list.find do |task|
      task.task_id == task_id
    end
    task.status = :complete
  end

end
