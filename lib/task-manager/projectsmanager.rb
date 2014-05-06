require 'pry'

class TM::ProjectsManager

  attr_reader :projects,  :name

  def initialize
    @projects = []
  end

  def create_project(name)
    @projects << TM::Project.new(name)
  end

  def list_projects
    @projects
  end

  def remaining_task(project_id)
    # binding.pry
    project = find_project_by_id(project_id)
    project.incompleted_task
  end

  def history(project_id)
    project = find_project_by_id(project_id)
    project.completed_task
  end

  def add_task(project_id, priority, description)
    project = find_project_by_id(project_id)
    project.add_task(project_id, priority, description)
  end

  def complete_task(task_id)
    task = find_task_by_id(task_id)
    task.completed = true
  end

  # def find_task_by_tag(tag)
  #   task_array = []
  #   @projects.each do |project|
  #     project.task.each do |item|
  #       task_array << item if item.tags.include?(tag)
  #     end
  #   end
  #   task_array
  # end

  def find_project_by_id(project_id)
    @projects.select { |item| item.id == project_id }.first
  end

  def find_task_by_id(id)
    task_hold = []
    @projects.each { |project| task_hold << project.task}
    task_hold.flatten.select { |task| task.task_id == id }.first
  end

end
