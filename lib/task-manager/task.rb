
class TM::Task
  attr_reader :description, :priority, :project_id, :status, :task_id, :created_at
  attr_accessor :status, :completed_at
  @@task_id = 0

  def initialize(project_id, desc, priority)
    @project_id = project_id
    @task_id = @@task_id + 1
    @description = desc
    @priority = priority
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now
    @completed_at = nil

    # Increment task_id class variable
    @@task_id = @task_id
  end


  # Reset class variables for rspec tests
  def self.reset_class_variables
    @@task_id = 0
  end
end
