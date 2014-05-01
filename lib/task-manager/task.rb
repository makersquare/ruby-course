require 'date'
class TM::Task

  attr_reader :project_id, :creation_date
  attr_accessor :description, :priority_number, :status, :due_date, :overdue

  def initialize(project_id, description, priority_number, status="incomplete",due_date)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @status = status
    @creation_date = Date.today
    @due_date = Date.parse(due_date)
    @overdue = "current"
  end


end
