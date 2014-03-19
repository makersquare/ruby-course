class TM::Project_list
  attr_accessor :projects

  def initialize
    @projects = []
  end

  def add_project(name)
    @projects << TM::Project.new(name)
  end

  def add_task(project_id, priority, description)
    target = @projects.select{|project| project.id == project_id}
    target.first.add_task(TM::Task.new(project_id, description, priority))
  end
end
