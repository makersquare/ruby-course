
require 'time'
class TM::Task
  attr_accessor :status
  attr_reader :project_id, :description, :priority_number, :id, :id_counter, :creation_date
  @@id_counter = 1
  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @id = @@id_counter
    @@id_counter += 1
    @status = "incomplete"
    @creation_date = Time.now
  end

  def self.id_counter
    @@id_counter
  end

  def self.id_counter=(value)
    @@id_counter=value
  end
end
