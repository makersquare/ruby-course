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
    hold_task = []
    TM.db.task.each do |key, value|
      if value[:pid] == @id && value[:completed] == false
        hold_task << value
      end
    end
    hold_task.sort_by { |task| [task[:creation_date], task[:priority], task[:id]] }
  end

  def completed_task
    hold_task = []
    TM.db.task.each do |key, value|
      if value[:pid] == @id && value[:completed] == true
        hold_task << value
      end
    end
    hold_task.sort_by { |task| [task[:priority], task[:id]] }
  end

  def destroy
    TM.db.destroy_project(@id)
  end

end
