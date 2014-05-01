require 'pry-debugger'
require 'time'

class TM::Task

  attr_accessor :complete_status, :description, :priority_number, :project_id
  attr_reader :task_id, :created_at

   @@task_id_count = 0
   @@task_list = []

  def initialize(description, priority_number, project_id)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @complete_status = false
    @@task_id_count += 1
    @task_id = @@task_id_count
    @@task_list << self
    @created_at = Time.now
    @completed_at = nil
  end

  # def change_priority(new_number)
  #   @priority_number = new_number
  # end

  def self.complete_task(task_id)
    completed_task = @@task_list[task_id - 1]
    completed_task.complete_status = true
  end

  def self.reset_class_variables
    @@task_id_count = 0
    @@task_list = []
  end

end


# be able to add tasks to a project (like books to a library)
# write a method on project to retrieve all tasks that have
# an project_id equal to the project and are either complete or incomplete

