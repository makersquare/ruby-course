
class TM::Task
  attr_reader :project_id, :desc, :priority, :id
  attr_accessor :complete
  @@id_count = 0
  @@all_tasks = []

  def initialize(p_id, desc, priority)
    @project_id = p_id
    @desc = desc
    @priority = priority
    @id = @@id_count += 1
    @complete = false
    @@all_tasks << self
  end

  def self.reset_id_count
    @@id_count = 0
  end

  def self.complete(id)
    t = find_task(id)
    t.complete = true
  end

  def self.find_task(id)
  end
end
