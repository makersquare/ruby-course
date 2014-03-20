require 'colorize'
class TM::ProjectList

  attr_accessor :projects

  def initialize()
    @projects = []
  end


  def add_project(project_name)
    project = TM::Project.new(project_name)
    @projects.push(project)
  end

  # def list_projects
    # @projects.each {|project|  puts " id: #{project.id} project name: #{project.project_name}".colorize(:red)}
  # end

  def add_task_to_project(description, priority, pid)
    new_task = TM::Task.new(description, priority, pid)

    project = @projects.find{|project| project.id == pid.to_i}
    if (!project)
      return "Project Doesn't exist"
    else
      project.add_task(new_task)
    end

    # project

  end

  def show_remaining_tasks(pid)
    selected_project = @projects.find {|project| project.id == pid}

    remaining_tasks = selected_project.tasks.select {|task| task.complete == false}

    remaining_tasks

  end

end
