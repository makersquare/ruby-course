
class TM::Task
  attr_reader :pid, :description, :tid, :time
  attr_accessor :completed, :priority

  @@task_id = 0
  @@tasks = []
  def initialize(pid, description, priority)
    @@tasks << self
    @pid = pid
    @description = description
    @priority = priority
    @@task_id += 1
    @tid = @@task_id
    @completed = false
    @time = Time.now
  end

  def set_complete
    @completed = true
  end

  def self.find_task(id)
    @@tasks.select{|task| task.tid == id}
  end

  # def self.mark_complete(task_id)
  #   task = @@tasks[task_id]
  #   task.complete = true
  #   task.completed_at = Time.now

  #   true
  # end

  def self.reset_class_variables
    @@task_id = 0
  end
end
