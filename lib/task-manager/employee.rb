require 'pry'

class TM::Employee

  attr_reader :name, :id

  def initialize(params)
    @name = params[:name]
    @id = params[:id]
  end

  def show_projects
    TM.db.projects_for_employee(eid: @id)
  end

  def show_task(status)
    TM.db.employee_task(eid: @id, completed: status[:completed])
  end


end
