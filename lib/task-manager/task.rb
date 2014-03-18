
class TM::Task
  # get rid of projID, description, priority, created
  attr_reader :projID, :description, :priority, :complete, :created

  def initialize(projID, description, priority)
    @projID = projID
    @description = description

    # set limits for priority number
    @priority = priority
    @complete = "incomplete"
    @created = Time.now
  end

  def complete?
    @complete
  end

end
