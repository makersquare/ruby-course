class TM::ProjectList

  attr_accessor :projects

  def initialize
    @projects = []
  end

  def add_project(name)
    newproject = TM::Project.new(name)
    @projects.push(newproject)
  end

  def add_new_task(description, project_id, priority)
    project_id = project_id.to_i
    priority = priority.to_i
    target = @projects.find{ |project| project.id == project_id}
    target.add_task(TM::Task.new(description, project_id, priority))
  end


end
