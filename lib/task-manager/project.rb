
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
    task = @tasks.select{|task| task_id == task.task_id}.first
    task.status = 1
  end

  # Used to reset class variables for rspec tests
  def self.reset_class_variables
    @@pid = 0
  end
end
