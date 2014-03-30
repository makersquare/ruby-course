class TM::Task
attr_reader :description, :priority_number, :tid
attr_accessor :status, :project_id, :employee_id

  @@task_counter = 0

  def self.gen_id
    @@task_counter += 1
    @@task_counter
  end

  def initialize(description, project_id, priority_number)
    @tid = TM::Task.gen_id
    @description = description
    @project_id = project_id
    @priority_number = priority_number
    @status = false
    @employee_id = nil
  end



end
