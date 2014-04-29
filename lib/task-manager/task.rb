
class TM::Task

    attr_reader :pid
    attr_accessor :tid_counter, :tid, :description, :pnum

    @@tid_counter = 0
    @@tasks = []
  def initialize(pid, description, pnum)
    @description = description
    @pnum = pnum
    @@tid_counter += 1
    @tid = @@tid_counter
  end

  # def markTID(task_id)
  #   if
  #   project.completed_tasks << task
  #   #Pushes task to completed_tasks array in project class
  # end
end
