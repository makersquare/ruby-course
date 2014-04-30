
class TM::Task
  attr_reader :description, :priority, :tid
  attr_accessor :completed

  @@task_id = 0
  def initialize(description, priority)
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

  def self.reset_class_variables
    @@task_id = 0
  end
end
