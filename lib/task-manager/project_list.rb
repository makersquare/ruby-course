class TM::ProjectList

  attr_accessor :projects

  def initialize()
    @projects = []
  end


  def add_project(project_name)
    project = TM::Project.new(project_name)
    @projects.push(project)
  end

  def list_projects
    @projects.each {|project|  puts project.project_name}
  end

end
