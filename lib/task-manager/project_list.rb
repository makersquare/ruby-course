

class TM::Projectlist
  attr_accessor :project_list

  def initialize
    @project_list = []

  end

  def create(name)
    project = TM::Project.new(name)
    return project
  end

  def add_projects(project)
    @project_list << TM::Project.new(project)

  end

  def add_task_project(project,task)
    @project_list.each do |project_instance|
      if project_instance == project
        project_instance.task_list << task
        return project_instance.task_list
      end
    end

  end

  def list_task_remain
   @project_list.each { |project|
      return project.task_list
   }

  end

  def list_task_complete
    @project_list.each { |project|
      return project.task_list
   }
  end

  def mark_task_complete
    tasks = @project_list[0].task_list
    tasks.each {|task|
      task.complete = true
      return task.complete
    }

  end


  # def list_task_remain(id)
  #   # select or find
  #   project = @project_list.select { |project|
  #     project.id
  #   }

  # end
# a = [ "a", "b", "c" ]


end
