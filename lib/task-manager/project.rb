
class TM::Project
  attr_reader :name, :id

  @@projects = [ ]
  @@counter  = 0

  def self.all
    @@projects
  end

  def self.find(project_id)
    @@projects.find {|p| p.id == project_id}
  end

  def initialize(name)
    @name = name
    @id   = @@counter += 1

    @@projects << self
  end

  def new_task(priority, description)
    TM::Task.new(id, priority, description)
  end

  def incompleted_tasks
    TM::Task.tasks_for(id)
  end

  def completed_tasks
    TM::Task.tasks_for(id, complete = true)
  end
end
