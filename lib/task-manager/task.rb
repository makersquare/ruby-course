
class TM::Task
  attr_accessor :project_id, :description, :priority_number, :id, :status, :id_counter
  @@id_counter = 1
  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @id = @@id_counter
    @@id_counter += 1
    @status = "incomplete"
  end

  def self.id_counter
    @@id_counter
  end

  def self.id_counter=(value)
    @@id_counter=value
  end
end
