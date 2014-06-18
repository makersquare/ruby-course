
class TM::Project
  attr_reader :id, :name, :completed, :created_at

  @@projects = [ ]
  # @@counter  = 0

  def self.all
    @@projects
  end

  def self.find(project_id)
    @@projects.find {|p| p.id == project_id}
  end

  def initialize(name)
    # @id   = @@counter += 1
    @name      = name
    @completed = false

    @@projects << self
  end

  def new_task(priority, description)
    TM::Task.new(id, priority, description)
  end

  def incompleted_tasks
    TM::Task.tasks_for(id)
  end

  def completed_tasks
    TM::Task.tasks_for(id, completed = true)
  end

  def create
    args = TM.db.create_project( [ @name, @completed ] )
    @id         = args[:id]
    @created_at = args[:created_at]
    self
  end

end
