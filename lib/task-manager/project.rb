
class TM::Project
  attr_accessor :id, :project_id, :tasks
  attr_reader :name


  def initialize(name)
    @name = name
    @project_id = self.object_id
    @tasks = Array.new(0)
  end

  def add_task(description, priority=3)
    @description = description
    @priority = priority
    @tasks << TM::Task.new(@project_id, description, priority)
  end

end

