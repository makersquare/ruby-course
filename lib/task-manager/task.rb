require 'pry-debugger'

class TM::Task

#class variables to assign tid, create tasks array, and completed tasks array
 @@tid = 0
 @@tasks = []
 @@completed_tasks = []

attr_accessor :new_task, :priority, :tid, :pid, :time,
:complete, :reset_class_variable, :tasks, :completed_tasks
#initialize creates new task. gives it a priority, assigns tid and pid, and time stamp
  def initialize(new_task, priority, pid)
    @new_task = new_task
    @priority = priority
    @@tid += 1
    @tid = @@tid
    @pid = pid
    @time = Time.now
    @complete = false
  end
#resets all class variables
  def self.reset_class_variable
    @@tid = 0
    @@tasks = []
    @@completed_tasks = []
  end
#class method to add new tasks to tasks array
  def self.add_tasks(new_task)
    @@tasks << new_task
  end
#getter for tasks array

  def self.tasks
    @@tasks
  end
#marks task as complete by id
  def self.is_complete(tid)
    completed = @@tasks.select{|task|task.tid == tid }
    completed = completed[0]
    completed.complete = true
    @@completed_tasks << completed
    #accepts tid as arguement and returns true with pid and tid
  end
#getter for completed tasks
  def self.completed
    @@completed_tasks
  end

end


