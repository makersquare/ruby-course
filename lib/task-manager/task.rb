
class TM::Task

  attr_reader :pid, :priority, :description, :id

  def initialize(id, pid, completed, description, priority)
    @id = id
    @pid = pid
    @completed = completed
    @description = description
    @priority = priority
    # @date_created = Time.now
    # @complete_date = @date_created + (86400 * 5)
  end

  def complete_task
    TM.db.update_task(@id, { completed: true })
  end

  def complete?
    @completed
  end

  # def over_due?
  #   Time.now > @complete_date ? true : false
  # end

end
