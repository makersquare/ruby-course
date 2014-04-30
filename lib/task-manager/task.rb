
class TM::Task
  attr_reader :description, :priority, :tid, :completed

  @@task_id = 0
  def initialize(description, priority)
    @description = description
    @priority = priority
    @@task_id += 1
    @tid = @@task_id
    @completed = false
    @time = Time.now
  end



  def self.reset_class_variables
    @@task_id = 0
  end
end
