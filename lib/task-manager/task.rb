
class TM::Task
  attr_reader :description, :priority, :project_id, :status, :task_id, :created_at
  attr_accessor :status, :completed_at
  @@task_id = 0
  @@task = []

  def initialize(project_id, desc, priority)
    @project_id = project_id
    @task_id = @@task_id + 1
    @description = desc
    @priority = priority
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now
    @completed_at = nil

    # Add task to task class variable array
    @@tasks << self
    # Increment task_id class variable
    @@task_id = @task_id
  end

  # Reset class variables for rspec tests
  def self.reset_class_variables
    @@task_id = 0
  end
end
