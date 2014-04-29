
class TM::Project

attr_reader :created, :project_id, :add_task
attr_accessor :name, :task, :project

@@project_count = 0

  def initialize(name="New Project")
    @project = []
    @name = name
    @created = Time.now
    @project_id = @@project_count
    @@project_count += 1
  end

  def add_task(task)
    @add_task = Task.new(task)
  end



end
