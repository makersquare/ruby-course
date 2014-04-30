
class TM::Task
  attr_reader :description, :priority, :project_id, :status, :task_id, :created_at
  attr_writer :status
  @@task_id = 0

  def initialize(project, desc, priority)
    @project_id = project.pid
    @task_id = @@task_id + 1
    @description = desc
    @priority = priority
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now

    # Increment task_id class variable
    @@task_id = @task_id
  end


  # Reset class variables for rspec tests
  def self.reset_class_variables
    @@task_id = 0
  end
end
