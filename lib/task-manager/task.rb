
class TM::Task
  attr_reader :task_id, :project_id, :creation_time
  attr_accessor :status
  @@counter = 0
  @@tasks_list = []

  def initialize project_id, description, priority_number
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @task_id = @@counter
    @@counter += 1
    @creation_time = Date.today
    @status = :incomplete
    @@tasks_list << self
  end

  def self.tasks_list
    @@tasks_list
  end

  def self.mark_complete(task_id)
    task = @@tasks_list.find do |task|
      task.task_id == task_id
    end
    task.status = :complete
  end

end
