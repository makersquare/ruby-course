
class TM::Project
  attr_reader :name, :id

  @@projects = [ ]
  @@counter  = 0

  def self.all
    @@projects
  end

  def initialize name
    @name = name
    @id   = @@counter += 1

    @@projects << self
  end

  def new_task(description, priority)
    task = TM::Task.new(description, priority, id)
    TM::Task.tasks << task
    task
  end

  def incompleted_tasks
    TM::Task.tasks_for(id)
  end

  def completed_tasks
    TM::Task.tasks_for(id, complete = true)
  end
end
