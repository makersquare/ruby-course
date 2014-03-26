class TM::DB
attr_accessor :projects, :tasks, :employees, :memberships

def initialize
  @projects = {}
  @tasks = {}
  @employees = {}
  @memberships = {}
end

def create_project(name)
  new_project = TM::Project.new(name)
  @projects[new_project.id] = new_project
  return new_project
end


end
