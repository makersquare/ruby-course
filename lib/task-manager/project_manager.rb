class TM::ProjectManager
  attr_reader :projects

  def add_project(name)
    p = TM::Project.new(name)
    @projects << name
  end
end