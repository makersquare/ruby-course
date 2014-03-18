
class TM::Project
  attr_reader :name, :id, :tasks

  @@projectcount = 0

  def initialize(name)
    @name = name
    @@projectcount += 1
    @id = @@projectcount
    @tasks = []
  end

  def addtask(project_id, description, priority)
    @tasks[project_id] = TM::Task.new(project_id, description, priority)
  end

  def markcomplete(project_id)
    @tasks[project_id].complete = true
  end
end
