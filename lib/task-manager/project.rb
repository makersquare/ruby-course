
class TM::Project

attr_reader :created, :project_id, :add_task
attr_accessor :name, :task

@@project_count = 0

  def initialize(name)
    @name = name
    @created = Time.now
    @project_id = @@project_count
    @@project_count += 1
    @task = []
  end

  def add_task(task)
    @add_task = Task.new(task)
  end



end
