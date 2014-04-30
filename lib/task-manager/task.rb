
class TM::Task
  attr_reader :description, :priority, :project_id

  def initialize(project, desc, priority)
    @project_id = project.pid
    @description = desc
    @priority = priority
  end
end
