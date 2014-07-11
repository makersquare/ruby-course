class TM::Task
  attr_reader :pid, :detail, :priority, :created, :complete, :id

  def initialize(pid, detail, priority=5, complete=false, id=nil, created=nil)
    @id = id
    @pid = pid
    @priority = priority
    @detail = detail
    @created = created
    @complete = complete
  end

  def complete!
    @complete = true
    TM.db.update_task(@id, {"complete" => @complete})
  end

  def save!
    @id, @created = TM.db.add_task(@pid, @priority, @detail, @complete)
  end
end
