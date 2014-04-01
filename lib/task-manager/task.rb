module TM
class Task

  @@num_tasks = 0 # Class variable tracking total # of tasks
  attr_reader :created, :id, :projID
  attr_accessor :complete, :description, :priority, :eid

  def initialize(projID, description, priority)
    @projID = projID
    @description = description

    # set limits for priority number: 1-5
    if priority > 5
      @priority = 5
    elsif priority < 1
      @priority = 1
    else
      @priority = priority
    end

    @@num_tasks +=1
    @id = @@num_tasks
    @complete = false
    @created = Time.now
  end

  def complete?
    @complete
  end


end
end
