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
    project = find_by_id(project_id)
    project.uncompleted_task
  end

  def history(project_id)
    project = @projects.select { |item| item.id == project_id }.first
    project.completed_task
  end

  def add_task(project_id, priority, description)
    project = find_by_id(project_id)
    project.task << TM::Task.new(project_id, priority, description)
  end

  def find_by_id(project_id)
    @projects.select { |item| item.id == project_id }.first
  end


end
