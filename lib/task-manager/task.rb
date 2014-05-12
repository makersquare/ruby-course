
class TM::Task

  attr_reader :pid, :priority, :description, :id, :creation_date

  def initialize(params)
    @id = params[:id]
    @pid = params[:pid]
    @completed = params[:completed]
    @description = params[:description]
    @priority = params[:priority]
    @creation_date = params[:creation_date]
  end

  def complete_task
    TM.db.update_task(@id, { completed: true })
  end

  def complete?
    @completed
  end

  def destroy
    TM.db.destroy_task(@id)
  end

end
