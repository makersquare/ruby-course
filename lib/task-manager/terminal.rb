class TM::TerminalClient

  attr_reader :projects

  def initialize
    @projects = []
  end

  def create_project(name)
    @projects << TM::Project.new(name)
  end

  def list_projects
    @projects
  end

  def remaining_task(project_id)
    project = @projects.select { |item| item.id == project_id }.first
    project.uncompleted_task
  end

end
