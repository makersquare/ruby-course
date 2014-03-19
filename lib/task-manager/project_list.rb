class TM::ProjectList

  attr_reader :project_list

  def initialize
    @project_list = []
  end

  def list_projects
    @project_list.each { |project| puts project.name }
  end
  def add_project(project_name)
    project = TM::Project.new(project_name)
    @project_list << project
  end

end

