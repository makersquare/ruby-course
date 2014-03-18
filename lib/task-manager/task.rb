
class TM::Task
attr_reader :project_id, :description, :priority_number, :status, :id

  @@task_counter = 0

  def self.gen_id
    @@task_counter += 1
    @@task_counter
  end

  def initialize(project_id, description, priority_number, status="incomplete")
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @status = status
    @id = TM::Task.gen_id

  end



end
