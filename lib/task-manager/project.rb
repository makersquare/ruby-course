
class TM::Project
  attr_reader :pid, :name, :tasks
  @@pid = 0

  def initialize(name)
    @name = name
    @pid = @@pid + 1
    @tasks = []

    # Increment class variable to keep ids unique
    @@pid = @pid
  end

  def add_task(task)
    @tasks << task
  end

  def complete_task(task_id)
    task = @tasks.select{ |task| task_id == task.task_id }.first
    task.status = 1
  end

  def completed_tasks
    completed_tasks = @tasks.select{ |task| task.status == 1 }
    completed_tasks.sort_by{ |task| task.created_at }
  end

  def incomplete_tasks
    incomplete_tasks = @tasks.select{ |task| task.status == 0 }
    incomplete_tasks.sort_by{ |task| task.priority }.reverse
  end

  # Used to reset class variables for rspec tests
  def self.reset_class_variables
    @@pid = 0
  end
end
