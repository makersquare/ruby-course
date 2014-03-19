require 'singleton'

# made a singleton verion of ProjectList
# a singleton 

class TM::ProjectList
  attr_reader :projects

  def initialize
    @projects = []
  end

  @@instance = TM::ProjectList.new

  def self.instance
    return @@instance
  end

  def create_project(title)
    proj = TM::Project.new(title)

    @projects << proj

    proj
  end



  # no need to test since so simple
  # def list_projects
  #   @projects
  # end

  def show_proj_tasks_remaining(pid)
    proj = @projects.find { |project| project.id == pid }

    proj.list_incomplete_tasks
  end

  def show_proj_tasks_complete(pid)
    proj = @projects.find { |project| project.id == pid }

    proj.list_completed_tasks
  end

  def add_task_to_proj(pid, desc, priority)
    proj = @projects.find { |project| project.id == pid }

    proj.add_task(desc, priority)

    proj
  end

  # def mark_task_as_complete(tid)
  # end

  private_class_method :new
end