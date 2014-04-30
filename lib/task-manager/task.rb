
class TM::Task

  attr_reader :project_id, :priority, :description, :task_id, :date_created
  attr_accessor :completed

  @@task_ids = 0

  def initialize(project_id, priority, description)
    @project_id = project_id
    @priority = priority
    @description = description
    @completed = false
    @@task_ids += 1
    @task_id = @@task_ids
    @date_created = Time.now
  end

  def complete
    if @completed == false
      @completed = true
      self
    end
  end

  def self.reset_class_variables
    @@task_ids = 0
  end

end
