
class TM::Task
  attr_reader :description, :priority, :project_id, :task_id, :created_at, :due_date, :tags
  attr_accessor :status, :completed_at, :overdue
  @@task_id = 0
  @@tasks = []

  def initialize(project_id, desc, priority, due_date,tags=[])
    @project_id = project_id
    @task_id = @@task_id + 1
    @description = desc
    @priority = priority
    @status = 0 # Initialize task as incomplete
    @created_at = Time.now
    @completed_at = nil
    @due_date = Date.parse(due_date)
    @overdue = 0
    @tags = tags

    # Add task to task class variable array
    @@tasks << self
    # Increment task_id class variable
    @@task_id = @task_id

    # Find associated project and add task to project
    project = TM::Project.get_project(project_id)
    project.tasks << self
  end

  def overdue?
    true if @due_date < Date.today
  end

  def self.complete_task(task_id)
    task = @@tasks.detect{ |task| task_id == task.task_id }
    task.completed_at = Time.now
    task.status = 1
  end

  def self.mark_overdue
    # Do this in a class method so all tasks can be updated as overdue at once. Not ideal.
    @@tasks.each do |task|
      task.overdue = 1 if task.overdue?
    end
  end

  # Reset class variables for rspec tests
  def self.reset_class_variables
    @@task_id = 0
    @@tasks = []
  end
end
