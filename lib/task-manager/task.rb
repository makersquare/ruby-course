require 'time'

class TM::Task
  attr_reader :tid, :description, :priority, :eid, :status, :creation_date

  def initialize(priority, description, pid, eid=1, status='incomplete', creation_date=nil)
    task = TM.orm.show_task
    @tid = task[0]
    @priority = task[1]
    @description = task[2]
    @pid = task[3]
    @eid = task[4]
    @status = task[5]
    @creation_date = task[6]
  end

  def show_task
    TM.orm.show_task
  end

  def update_complete
    TM.orm.update_complete(@pid, @tid)
    @status = 'complete'
  end
end
