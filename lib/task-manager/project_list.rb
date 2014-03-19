class TM::ProjectList

  attr_reader :project_list

  def initialize(project_list)
    @project_list = project_list
  end

  def add_project(project_name)
    project = TM::Project.new(project_name)
    @project_list << project
  end

end

