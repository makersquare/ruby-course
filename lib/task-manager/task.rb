require 'time'

class TM::Task

  attr_accessor  :priority_no, :status, :project_id_counter, :complete
  attr_reader :id, :project_id, :description, :created_at

  def initialize(project_id, description, priority_no)
    @project_id = project_id
    @description = description
    @priority_no = priority_no
    @id = self.class.project_id_counter
    @@project_id_counter += 1
    @created_at = Time.now
    @complete ||= []

  end

  def complete?
    @complete
  end

  def status
    complete? ? true : false
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

  private
def self.project_id_counter
  temp = @@project_id_counter ||= 0
  @@project_id_counter += 1
  temp
end
end
