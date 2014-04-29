
class TM::Project

  attr_reader :name, :id, :projects
  attr_accessor :task

  @@unique_id = 0

  def initialize(name)
    @name = name
    @id = @@unique_id += 1
    @task = []
  end

  def completed_task
    completed = []
    @task.each do |task_item|
      completed << task_item if task_item.completed
    end
    completed.sort_by { |item| item.date_created }
  end

end
