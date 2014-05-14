require 'pry'

class TM::Project

  attr_reader :name, :id
  # attr_accessor :task

  def initialize(project_data)
    @name = project_data[:name]
    @id = project_data[:id]
    @completed = project_data[:completed]
  end

  def complete_project
    TM.db.update_project(@id, { completed: true })
  end

  def completed?
    @completed
  end

  def incomplete_task
    incomplete = TM.db.project_task(@id, completed: false)
    if incomplete
      incomplete.sort_by { |task| [task.priority, task.creation_date, task.id] }
    else
      false
    end
  end

  def completed_task
    complete = TM.db.project_task(@id, completed: true)
    if complete
      complete.sort_by { |task| [task.priority, task.id] }
    else
      false
    end
  end

  def destroy
    TM.db.destroy_project(@id)
  end

  def show_employees
    employees = []
    TM.db.employee_projects.each do |key, value|
      if value[:pid] == @id
        employees << TM.db.get_employee(value[:eid])
      end
    end
    employees
  end

end
