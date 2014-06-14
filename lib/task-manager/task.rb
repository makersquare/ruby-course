
class TM::Task

  attr_reader :pid, :desc, :priority, :creation_time, :complete, :task_id

  @@task_index = 0
  @@master_task_list = {}

  def initialize(pid, desc, priority)
    @pid = pid
    @desc = desc
    @priority = validate_priority(priority)
    @creation_time = Time.now.utc
    @complete = false
    @task_id = @@task_index
      @@task_index += 1
    @@master_task_list[@task_id] = self
  end

  def mark_complete
    @complete = true
  end

  def self.get_task(tid)
    return @@master_task_list[tid]
  end

  # reset method
  def self.destroy_all_tasks(bool)
    if bool
      @@task_index = 0
      @@master_task_list = {}
    end
  end

  private
  def validate_priority(priority)
    if priority > 10
      return 10
    elsif priority < 0
      return 0
    else
      return priority
    end
  end

end
