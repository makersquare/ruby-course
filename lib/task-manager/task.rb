require 'pry-debugger'
class TM::Task

  attr_accessor :complete_status, :description, :priority_number, :project_id
  attr_reader :task_id

   @@task_id_count = 0
   @@task_list = []

  def initialize(task_id, description, priority_number)
    # @project_id = project_id
    @description = description
    @priority_number = priority_number
    @@task_id_count += 1
    @task_id = @@task_id_count
    @complete_status = false
    @@task_list << self
  end

  def change_priority(new_number)
    @priority_number = new_number
  end

  def self.complete_task(task_id)
    completed = @@task_list[task_id - 1]
    completed.complete_status = true
  end

  def self.reset_class_variables
    @@task_id_count = 0
    @@task_list = []
  end

end



