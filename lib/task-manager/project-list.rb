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

  def show_proj_tasks_remaining(pid)
    # sanitization - should also add this as expectation to test
    pid = pid.to_i

    proj = @projects.find { |project| project.id == pid }

    proj.list_incomplete_tasks
  end

  def show_proj_tasks_complete(pid)
    # sanitization - should also add this as expectation to test
    pid = pid.to_i

    proj = @projects.find { |project| project.id == pid }

    proj.list_completed_tasks
  end

  def add_task_to_proj(pid, desc, priority)
    # sanitization - should also add this as expectation to test
    pid = pid.to_i
    priority = priority.to_i

    proj = @projects.find { |project| project.id == pid }

    added_task = proj.add_task(desc, priority)
  end

  def mark_task_as_complete(tid)
    # sanitization - should also add this as expectation to test
    tid = tid.to_i

    project = nil

    @projects.each do |proj|
      if proj.include_task?(tid)
        proj.mark_as_complete(tid)

        # set project variable to point to the project
        # that has the task we are looking for
        project = proj
      end
    end

    # return the task with id = tid
    marked_task = project.tasks.find { |task| task.id == tid }
  end

  private_class_method :new

end