class TM::ProjectList
  attr_reader :project_list

  def initialize
    @project_list = []
  end

  def create_project(name)
    @project_list << TM::Project.new(name)
  end

  def get_project
  end

end

