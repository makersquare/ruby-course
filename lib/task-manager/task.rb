class TM::Task
  attr_reader :project_id, :desc, :priority, :id, :timestamp
  attr_accessor :complete
  @@id_count = 0
  @@all_tasks = {}

  def initialize(p_id, desc, priority)
    @project_id = p_id
    @desc = desc
    @priority = priority
    @id = @@id_count += 1
    @complete = false
    @timestamp = Time.now
    @@all_tasks[@id] = self
  end

  def self.reset_class_variables
    @@id_count = 0
    @@all_tasks = {}
  end

  def self.mark_complete(id)
    @@all_tasks[id].complete = true
  end

  def self.retrieve_tasks(p_id, complete)
    res = @@all_tasks.values.select do |task|
      task.complete == complete &&
        task.project_id == p_id
    end
    res.sort do |p1, p2|
      if p1.priority < p2.priority
        x = -1
      elsif p2.priority < p1.priority
        x =  1
      else
        if p1.timestamp < p2.timestamp
          x = -1
        else
          x = 1
        end
      end
    end
  end
end
