require 'colorize'

class TM::ProjectList

  attr_reader :project_list

  def initialize
    @project_list = []
  end

  def add_project(project_name)
    project = TM::Project.new(project_name)
    # id = project.id
    @project_list << project
  end

  def add_task_to_project(description, priority, id)
    new_task = TM::Task.new(description, priority, id)
    id = id.to_i
    priority = priority.to_i
    project = @project_list.find { |project| project.id == id}
    if !project
      "project doesn't exist"
    else
     project.add_task(new_task)
    end
  end

  def show_remaining_tasks(pid)
    selected_project = @project_list.find { |project| project.id == pid }
    remaining_tasks = selected_project.tasks.select { |task| task.complete == false }
  end

  def show_completed_tasks(pid)
    selected_project = @project_list.find { |project| project.id == pid }
    remaining_tasks = selected_project.tasks.select { |task| task.complete == true }
  end

  def mark_complete(tid)
    tid = tid.to_i
    project = @project_list.find { |project| project.tasks.find { |task| task.id == tid } }
    task = project.tasks.find { |task| task.id == tid }
    task.complete=true
  end

end

