
class TM::Task
attr_reader :task_id, :description, :priority, :timecreated
attr_accessor :complete

  @@task_count = 0

  def initialize(description, priority)
    @task_id = TM::Task.gen_id
    @description = description
    @priority = priority
    @complete = false
    @timecreated = Time.now
  end

  def self.gen_id
    @@task_count += 1
  end
end
