require 'pry'

class TM::Project

  attr_reader :name, :id
  # attr_accessor :task

  def initialize(params)
    @name = params[:name]
    @id = params[:id]
    @completed = params[:completed]
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
      incomplete.sort_by { |task| [task.creation_date, task.priority, task.id] }
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

end
