
class TM::Task

  attr_reader :pid, :priority, :description, :id, :creation_date,  :eid

  def initialize(params)
    @id = params[:id]
    @pid = params[:pid]
    @completed = params[:completed]
    @description = params[:description]
    @priority = params[:priority]
    @creation_date = params[:creation_date]
    @eid = params[:eid]
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

  def assign_employee(id)
    TM.db.update_task(@id, eid: id) if TM.db.get_membership(@pid)[id]
  end

  def remove_employee
    # binding.pry
    if @eid
      TM.db.update_task(@id, eid: false)
    else
      false
    end
  end

end
