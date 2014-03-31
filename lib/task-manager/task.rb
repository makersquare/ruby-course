class TM::Task
  @@counter = 0

  attr_reader :project_id, :description, :id, :creation_date
  attr_accessor :priority, :pid, :complete, :eid


  def self.generate_id
    @@counter += 1
    @@counter
  end

  def initialize(description, priority=nil, pid=nil, eid=nil, complete=false)
    @pid = pid
    @description = description
    @priority = priority
    @complete = complete
    @id = TM::Task.generate_id
    @creation_date = Time.now
    @eid = eid
  end


end
