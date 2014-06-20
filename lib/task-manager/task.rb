require 'time'

class TM::Task
  attr_accessor :tid, :description, :priority, :status, :creation_date
  # @@tasks = []

  def initialize(priority, description, pid, eid=nil, status, creation_date)
    @description = description
    @priority = priority
    @pid = pid
    @eid = eid
    @tid = tid
    # @@tasks << self
    @status = "incomplete"
    @creation_date = creation_date
  end

  def update_complete
    @status = "complete"
  end
end
