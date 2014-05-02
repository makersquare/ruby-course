
class TM::Task

  @@all_tasks = []  #an array of all tasks
  @@task_id_count = 0 #a way to begin counting the amount of tasks

  attr_reader :project_id, :task_description, :task_priority_number, :task_id
  attr_accessor :completed, :creation_date

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
    @@all_tasks << self
  end


  def self.completed(task_id)
    @@all_tasks.select do |task|          #iterates through @@all_tasks array using 'task' as an argument where 'task' represents an instance
      if task.task_id == task_id        #note, you can use 'task' methods here
        task.completed = true           #you can also read/write 'completed' instance variable because of the attr_accessor
        task.creation_date = Time.now   #also using 'task' instance variable of creation_date. This should update the time-stamp
      end
    end
    true
  end

#
  def self.reset_class_variables
    @@id_count = 0
  end


end
