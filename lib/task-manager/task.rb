
class TM::Task
  attr_reader :description, :priority, :project_id, :task_id, :created_at, :due_date
  attr_accessor :status, :completed_at
  @@task_id = 0
  @@tasks = []

  def initialize(project_id, desc, priority, due_date)
    @project_id = project_id
    @task_id = @@task_id + 1
    @description = desc
    @priority = priority
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now
    @completed_at = nil
    @due_date = Date.parse(due_date)

    # Add task to task class variable array
    @@tasks << self
    # Increment task_id class variable
    @@task_id = @task_id

    # Find associated project and add task to project
    project = TM::Project.get_project(project_id)
    project.tasks << self
  end

  def self.complete_task(task_id)
    task = @@tasks.detect{ |task| task_id == task.task_id }
    task.completed_at = Time.now
    task.status = 1
  end

  # Reset class variables for rspec tests
  def self.reset_class_variables
    @@task_id = 0
    @@tasks = []
  end
end
