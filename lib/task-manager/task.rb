require 'time'

class TM::Task

  attr_accessor :project_id, :description, :priority_no, :id, :status, :project_id_counter, :creation_date
  @@project_id_counter = 1

  def initialize(project_id, description, priority_no)
    @project_id = project_id
    @description = description
    @priority_no = priority_no
    @id = @@project_id_counter
    @@project_id_counter += 1
    @status = "incomplete"
    @creation_date = Time.now
  end

  def self.reset_Class_variable
    @@project_id_counter = 1
  end

  def self.project_id_counter
    @@project_id_counter
  end

  def self.project_id_counter=(count)
    @@project_id_counter = count
  end
end
