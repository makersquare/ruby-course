class TM::Task
  attr_reader :project_id, :description, :priority, :id, :timestamp
  attr_reader :complete

  def initialize(p_id, desc, priority, id, complete, timestamp)
    @project_id = p_id
    @description = desc
    @priority = priority
    @id = id
    @complete = complete
    @timestamp = timestamp
  end

  def mark_complete
    @complete = true
    # db.update_task(self.id, :complete => true)
  end

  # def self.retrieve_tasks(p_id, complete)
  #   res = @@all_tasks.values.select do |task|
  #     task.complete == complete &&
  #       task.project_id == p_id
  #   end
  #   res.sort do |p1, p2|
  #     if p1.priority < p2.priority
  #       x = -1
  #     elsif p2.priority < p1.priority
  #       x =  1
  #     else
  #       if p1.timestamp < p2.timestamp
  #         x = -1
  #       else
  #         x = 1
  #       end
  #     end
  #   end
  # end
end
