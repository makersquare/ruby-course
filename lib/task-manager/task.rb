
class TM::Task

  attr_reader :pid, :priority, :description, :id, :creation_date

  def initialize(id, pid, completed, description, priority, creation_date)
    @id = id
    @pid = pid
    @completed = completed
    @description = description
    @priority = priority
    @creation_date = creation_date
  end

  def complete_task
    TM.db.update_task(@id, { completed: true })
  end

  def complete?
    @completed
  end

end
