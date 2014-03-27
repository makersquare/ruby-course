require 'time'

class TM::Task
  @@counter = 0

  attr_reader :description, :id, :date_created
  attr_accessor :priority, :pid, :complete, :eid

  def initialize(description, priority=nil, pid=nil, eid=nil, complete=false)
    @pid = pid
    @eid = eid
    @description = description
    @priority = priority
    @complete = complete
    @id = @@counter += 1
    @date_created = Time.now
  end



end
