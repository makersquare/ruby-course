
class TM::Project
  attr_reader :name, :id, :tasks

  @@library=[]

  def initialize(name)
    @name = name
    @@library << self
    @id = @@library.length - 1
    @tasks = []
  end

  def self.library
    @@library
  end

  def add_task(task_description,task_priority)
    @tasks<<TM::Task.new(@id, task_description, task_priority, @tasks.length)
    # we return @tasks.length-1 for purposes of setting the task id
    @tasks.length - 1
  end

  def complete_task(task_id)
    @tasks[task_id].change_status
  end

  def list_complete_tasks
    complete = @tasks.select{|task| task.task_is_completed}
    complete.sort!{ |task1, task2| task1.creation_date <=> task2.creation_date }
  end

  def list_incomplete_tasks
    incomplete = @tasks.select{|task| !task.task_is_completed}
    incomplete.sort!{ |task1, task2| task1.creation_date <=> task2.creation_date }
    incomplete.sort!{ |task1, task2| task1.priority <=> task2.priority }
  end
end
