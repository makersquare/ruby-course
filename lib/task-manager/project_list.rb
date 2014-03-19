class TM::ProjectList

  attr_accessor :projects

  def initialize
    @projects = []
  end

  def add_project(name)
    newproject = TM::Project.new(name)
    @projects.push(newproject)
  end

  def add_task(project_id, description, priority)
    target = @projects.find{ |project| project.id == project_id}
    target.add_task(TM::Task.new(project_id, description, priority))
  end


end
