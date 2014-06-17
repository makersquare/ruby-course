
class TM::Task
  attr_reader :priority, :tid, :description, :pid, :time
  attr_accessor :status


  @@counter = 0
  @@tasks = []

  def initialize priority, pid, description
    @priority = priority
    @pid = pid
    @description = description
    @@counter += 1
    @tid = @@counter
    @status = :incomplete
    @time = Time.now
    @@tasks << self
  end

  def complete
    @status = :complete
  end

  def self.mark_complete tid
   task = @@tasks.find{|t| t.tid == tid}
   task.complete
  end

  def self.get_tasks
    @@tasks
  end

end
