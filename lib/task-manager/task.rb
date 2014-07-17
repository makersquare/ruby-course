require 'time'

class TM::Task
  attr_reader :project_id, :priority_number, :task_description, :task_creation_date
  attr_reader :task_id, :task_list
  attr_accessor :task_complete_status

  @@task_id_counter = 0
  @@task_list = []

  def initialize(task_description, priority_number, project_id)
    @task_description = task_description
    @priority_number = priority_number
    @project_id = project_id
    @task_complete_status = false
    @task_creation_date = Time.now
    @@task_id_counter += 1
    @task_id = @@task_id_counter
    @@task_list << self
  end

  # finds a task in the @@task_list array and marks it complete
  def mark_task_complete(task_id)
    task_to_mark_complete = @@task_list.find{ |task| task.task_id == task_id}
    if task_to_mark_complete.task_complete_status == false
      task_to_mark_complete.task_complete_status = true
    else
      return "Error: task already complete."
    end
  end

  def self.reset_class_variables
    @@task_id_counter = 0
    @@task_list
  end

end
