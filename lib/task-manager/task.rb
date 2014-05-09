
class TM::Task

  #a way to begin counting the amount of tasks
  @@task_id_count = 0
  @@all_tasks = []

  attr_accessor :creation_date, :completed, :task_priority_number
  attr_reader :project_id, :task_description, :task_id, :all_tasks

  # .new method - creates instances of the TM::Task class
  # each @'value' is called an instance variable
  # these are the attributes which are specific to the instance

  def initialize(project_id, task_description, task_priority_number)
    @project_id = project_id
    @task_description = task_description
    @task_priority_number = task_priority_number
    @completed = false                  #creating a new task means it's not complete
    @task_id = @@task_id_count          #assigns a task-id number
    @@task_id_count += 1                #ensures that each task-id number increments by 1
    @creation_date = Time.now           #puts a time stamp on newly created tasks
    # @all_tasks = @@all_tasks
  end


  def self.completed(task_num)
    task = @@all_tasks.select { |x| x.task_id == task_num }
    task = task[0]
    task.completed = true
    task.creation_date = Time.now
  end

  def self.reset_class_variables
    @@id_count = 0
    @@all_tasks = []
  end

end
