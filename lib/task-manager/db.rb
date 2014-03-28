
 require_relative "../task-manager.rb"

# TM.db

# class Terminal
#   def start
#     TM.db.this
#     TM.db.that
#     TM.db.yra
#   end
# end
module TM

  def self.db
    @db_instance ||= DB.new
  end

  class DB
    attr_accessor :project_list, :memberships, :task_project, :employees, :tasks



    def initialize
      @project_list = {}
      @memberships = []
      @task_project = {}
      @tasks = {}
      @employees = {}
      # consider @project_list = [ { eid: 1, pid: 1}, { eid: 1, pid: 2 } ]
    end

    # creates/adds employee to database
    def create_employee(name)
      emp = Employee.new(name) #instante employee object
      @employees[emp.id] = emp #make hash key = value
      emp  #this method will also return the emp if you want
    end    # r


    def create_project(name)
      proj = Project.new(name)
      @project_list[proj.id] = proj
      proj
    end

    def create_task(pid,descr,priority_num)
      task = Task.new(pid,descr,priority_num)
      #@task_project[]
      @tasks[task.id] = task
      task
    end

    def get_project(pid)
      @project_list[pid]
    end

    def update_project(pid,new_name)
      proj = @project_list[pid]
      proj.name = new_name
    end

    def delete_project(pid)
      @project_list.delete(pid)
      @project_list
    end

    def delete_employee(eid)
      @employees.delete(eid)
      @employees
    end

    def get_task(tid)
      @tasks[tid]
    end

    def delete_task(tid)
      @tasks.delete(tid)
      @tasks
    end

    def update_tasks(tid, pid, descr, priority_num)
      task = @tasks[tid]
      task.descr = descr
      task.proj_id = proj_id
      task
    end

    def testing
      @db
    end


    def create_projects(name)
      @project_list << TM::Project.new(name)

    end

    def add_task_project(projectid, proj_id, descr, priority_num)
      @project_list.each do |project_instance|
        if project_instance.id == projectid
          project_instance.task_list << TM::Task.new(proj_id, descr, priority_num)
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
  end
end



