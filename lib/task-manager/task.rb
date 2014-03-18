
class TM::Task
  attr_reader :projID, :description, :priority, :complete

  def initialize(projID, description, priority)
    @projID = projID
    @description = description
    # set limits for priority number
    @priority = priority
    @complete = "incomplete"
  end

  def complete?
    @complete
  end

end
