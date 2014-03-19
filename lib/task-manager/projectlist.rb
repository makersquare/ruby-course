class TM::ProjectList
  attr_reader :projects

  def initialize
    @projects = []
  end

  def addproject(name)
    project = TM::Project.new(name)
    @projects[project.id] = project
  end
end
