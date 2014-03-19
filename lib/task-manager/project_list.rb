class TM::ProjectList

  attr_accessor :projects

  def initialize
    @projects = []
  end

  def create_project(name)
    newproject = TM::Project.new(name)
    @projects.push(newproject)
  end

  # def list_projects
  #   @projects
  # end


end
