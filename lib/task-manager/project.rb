require 'pry-debugger'
class TM::Project
  attr_reader :name, :id, :complete
  @@id_count = 0

  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
    @tasks = []
    @completed = []
  end

  def add_task(task)
    task.project_id = self.id
    @tasks << task
  end

  def complete
    @tasks.each do |task|
        task.complete
    end
  end

  def completed_tasks
    @tasks.each do |task|
      if task.completed == true
        @completed << task
      end
    end

    @completed.sort_by! do |task|
      task.creation_date
    end
    @completed
  end


  def completed_tasks_by_priority
    @tasks.each do |task|
      if task.completed == true
        @completed << task
      end
    end

    @completed.sort_by! do |task|
      task.creation_date
    end
    @completed.sort_by! do |task|
      task.priority_number
    end
    @completed
  end

  def self.reset_class_variables
    @@id_count = 0
  end
end











