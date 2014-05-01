
class TM::Task
  @@counter = 1
  @@tasks = []
  attr_reader :description, :project_id, :priority, :task_id, :creation_date
  attr_accessor :status, :date_completed

  def initialize(description, project_id, priority)
    @description = description
    @project_id = project_id
    @priority = priority
    @task_id = @@counter
    @@counter += 1
    @status = "Not completed"
    @date_completed = nil
    @creation_date = Date.today
    @@tasks << self
  end

  def self.tasks
    @@tasks
  end

  def self.reset_class_variables
    @@counter = 1
    @@tasks = []
  end

  def self.mark_complete(task_id)
    @@tasks.each do |task|
      if task.task_id == task_id
        task.status = "Completed"
        task.date_completed = Date.today.to_s
      end
    end
  end
end
