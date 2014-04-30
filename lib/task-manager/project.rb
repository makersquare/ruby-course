
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

  def add_task(project,desc,priority)
    task = TM::Task.new(project, desc, priority)
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
    # Find incomplete tasks and sort by highest priority first.
    incomplete_tasks = @tasks.select{ |task| task.status == 0 }
    incomplete_tasks = incomplete_tasks.sort_by{ |task| [ -task.priority, task.created_at] }
  end

  # Used to reset class variables for rspec tests
  def self.reset_class_variables
    @@pid = 0
  end
end
