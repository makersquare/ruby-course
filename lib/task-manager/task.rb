
class TM::Task

  attr_reader :project_id, :priority, :description, :task_id, :date_created, :complete_date
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
    @complete_date = @date_created + (86400 * 5)
    @happy = true
  end

  def complete
    if @completed == false
        @completed = true
      self
    end
  end

  def over_due?
    Time.now > @complete_date ? true : false
  end

  def self.reset_class_variables
    @@task_ids = 0
  end

end
