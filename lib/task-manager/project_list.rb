require 'colorize'

class TM::ProjectList

  attr_reader :project_list

  def initialize
    @project_list = []
  end

  def add_project(project_name)
    project = TM::Project.new(project_name)
    @project_list << project
  end

  def add_task_to_project(description, priority, id)
    new_task = TM::Task.new(description, priority, id)
    project = @project_list.find { |project| project.id == id}
    if !project
      "project doesn't exist"
    else
     project.add_task(new_task)
    end
  end

end

