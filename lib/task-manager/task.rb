
class TM::Task
attr_reader :task_id, :description, :priority, :timecreated, :project_id, :employee_id
attr_accessor :complete

  @@task_count = 0

  def initialize(description, priority, project_id)
    @task_id = TM::Task.gen_id
    @description = description
    @priority = priority
    @complete = false
    @timecreated = Time.now
    @project_id = project_id
    @employee_id = nil
  end

  def self.gen_id
    @@task_count += 1
  end
end
