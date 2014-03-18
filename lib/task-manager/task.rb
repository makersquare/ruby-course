
class TM::Task

  @@id = 0
  # get rid of projID, description, priority, created
  # make pending related tests
  attr_reader :projID, :description, :priority, :created

  def initialize(projID, description, priority)
    @projID = projID
    @description = description

    # set limits for priority number
    if priority > 5
      @priority = 5
    elsif priority < 1
      @priority = 1
    else
      @priority = priority
    end

    @@id +=1
    @complete = "incomplete"
    @created = Time.now
  end

  def complete?
    @complete
  end

  def mark_complete()
    @complete = "complete"
  end

  def mark_incomplete()
    @complete = "incomplete"
  end

  def id
    @@id
  end

end
