

class TM::Projectlist
  attr_accessor :project_list

  def initialize
    @project_list = []

  end



  # def create(name)
  #   project = TM::Project.new(name)
  #   return project
  # end

  def add_projects(name)
    @project_list << TM::Project.new(name)

  end

  def add_task_project(projectid, proj_id, descr, priority_num, task_id)
    @project_list.each do |project_instance|
      if project_instance.id == projectid
        project_instance.task_list << TM::Task.new(proj_id, descr, priority_num, task_id)
        return project_instance.task_list
      else
        return nil
      end
    end
  end

  def list_task_remain(id)
     @project_list.each do |project|
       if project.id == id
         return project.retrieve_incomplete_tasks

       else
         return nil
       end
     end
  end


  def list_task_complete(id)
    @project_list.each do |project|
      if project.id == id
        return project.retrieve_complete_tasks
      end
   end
  end





  # def list_task_remain(id)
  #   # select or find
  #   project = @project_list.select { |project|
  #     project.id
  #   }

  # end
# a = [ "a", "b", "c" ]


end
