
class TM::Task

  @@id = 0
  # get rid of projID, description, priority, created, complete
  # make pending related tests
  attr_reader :projID, :description, :priority, :created, :complete

  def initialize(projID, description, priority)
    @projID = projID
    @description = description
    @@id +=1
    # set limits for priority number
    @priority = priority
    @complete = "incomplete"
    @created = Time.now
  end

  def complete?
    @complete
  end

  def mark_complete
    @complete = "complete"
  end

  def mark_incomplete
    @complete = "incomplete"
  end

end
