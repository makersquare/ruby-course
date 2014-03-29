
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
# @employees = {   # this is the employees hash
#     1 => "emp_obj_1",
#     2 => "emp_obj_2"

#   }

#   @memberships = [ {pid: 1, eid: 1}, {pid: 1, eid: 2}, {pid: 2, eid: 1}]


#   proj_with_pid_1 = @memberships.select do |memb|
#     memb[:pid] == 1

#   end
#   #=> proj_with_pid_1 = [{pid: 1, eid: 1}, {pid: 1, eid: 2}]

#   emps_of_proj_with_pid_1 = proj_with_pid_1.map do |memb|

#     @employees[memb[:eid]]
#   end
  #=> emps_of_proj_with_pid_1 = ["emp_obj_1", "emp_obj_2"]



    def initialize
      @project_list = {}
      @memberships = []
      @task_project = {}   # put in a task id -----> the project it is with.
      @tasks = {}
      @employees = {}
      # consider @memberships = [ { eid: 1, pid: 1}, { eid: 1, pid: 2 } ]
    end            # @memberships[0][:eid]

   # @memberships.select { |memb| memb[:eid] == 1 }

    ###########################
    ## Employee CRUD Methods ##
    ###########################

    # creates/adds employee to database
    def create_employee(name)
      emp = Employee.new(name) #instante employee object
      @employees[emp.id] = emp #make hash key = value
      emp  #this method will also return the emp if you want
    end    # r

    def update_employee(eid, name)
      emp = @employees[eid]
      emp.name = name
      emp
    end

    def delete_employee(eid)
      @employees.delete(eid)
      @employees
    end

    def list_emp
      @employees
    end

    ###########################
    ## Employee CRUD Methods ##
    ###########################



    def create_project(name)
      proj = Project.new(name)
      @project_list[proj.id] = proj
      proj
    end

    def create_task(pid,eid,descr,priority_num)
      # will assign a task, to project, based on pid
      task = Task.new(pid,eid,descr,priority_num)
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

    def list_all_proj
      @project_list
    end

    def get_task(tid)
      @tasks[tid]
    end

    def delete_task(tid)
      @tasks.delete(tid)
      @tasks
    end

    def update_tasks(tid, pid,eid, descr, priority_num)
      task = @tasks[tid]
      task.descr = descr
      task.proj_id = pid
      task.emp_id = eid
      task.priority_num = priority_num
    end

    def assign_task_emp(task_id,employee_id)
      updating_task = @tasks[task_id]
      updating_task.emp_id = employee_id
      updating_task
    end

    def add_membership(employee_id,project_id)
      @memberships << {:eid => employee_id, :pid =>project_id}
    end

    def show_projects_for_emp(employee_id)
      emp_id_with_proj = @memberships.select do |hash|
         hash[:eid] == employee_id
          #iterate through array, get hash
          # check if the value of the has is employee_id
          # emp_id_with_proj should return an array with the hashes
      end # with the key :eid pointing to the employee id
      emp_id_with_proj.map do |memb|
        @project_list[memb[:pid]] # map returns array
      end # go through project_list hash, with the project id key, getting all projects with same id
    end


    def show_employees_for_proj(project_id)
      proj_id_with_emp = @memberships.select  do |memb|
        memb[:pid] == project_id # will return array
                                 # with hashes with correct pid
      end
      proj_id_with_emp.map do |memb|
        @employees[memb[:eid]]
      end
    end

    def get_tasks_for_emp(employee_id)
      @tasks.values.select do |task| # values gets the keys as an array
        task.emp_id == employee_id # array is task objects
      end # task.emp_id is accessing the task employee id, if equal to parameter
    end   # will select it, and add it to an array, which is returned

    def get_task_for_proj(project_id)
      #@task is a hash, you want to search through it's value(task object)
      @tasks.values.select do |task| # selct on task array
        task.proj_id == project_id  #if attribute project id of task is === to paramter select it
      end
    end

    def mark_task_complete(task_id)
      thetask = @tasks.values.find { |task|
        task.id == task_id
      }
      thetask.complete = true
    end

    def remaining_task_emp(employee_id)
      task_for_emp = @tasks.values.select do  |task|
        task.emp_id == employee_id && task.complete == false
      end

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



