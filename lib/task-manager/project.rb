
class TM::Project
  attr_reader :pid, :name, :tasks
  @@pid = 0
  @@projects = []

  def initialize(name)
    @name = name
    @pid = @@pid + 1
    @tasks = []

    # Increment class variable to keep ids unique
    @@pid = @pid
    # Add project to projects array
    @@projects << self
  end

  def add_task(task)
    @tasks << task
  end

  def complete?(task)
    if task.status == 1
      true
    else
      false
    end
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
    @@projects = []
  end
end
