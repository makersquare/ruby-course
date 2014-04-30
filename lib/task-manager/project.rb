
class TM::Project

  attr_reader :name, :id, :projects
  attr_accessor :task

  @@unique_id = 0

  def initialize(name)
    @name = name
    @@unique_id += 1
    @id = @@unique_id
    @task = []
  end

  def completed_task
    completed = @task.select do |task_item|
      task_item.completed
    end
    completed.sort_by { |item| item.date_created }
  end

  def incompleted_task
    incompleted = @task.select do |task_item|
      task_item.completed == false
    end
    incompleted.sort_by { |item| [item.priority, item.task_id] }
  end

  def add_task(project_id, priority, description)
    task = TM::Task.new(project_id, priority, description)
    @task << task
  end

  def self.reset_class_variables
    @@unique_id = 0
  end

end
