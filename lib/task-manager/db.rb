
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
      @task_project = {}   # put in a task id -----> the project it is with.
      @tasks = {}
      @employees = {}
      # consider @memberships = [ { eid: 1, pid: 1}, { eid: 1, pid: 2 } ]
    end            # @memberships[0][:eid]



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

    def get_employee(emp_id)
      @employees[emp_id]
    end


    def show_employees_for_proj(project_id)
      proj_id_with_emp = @memberships.select  do |memb|
        memb[:pid] == project_id.to_i # will return array
                                 # with hashes with correct pid
      end
      proj_id_with_emp.map do |memb|
        @employees[memb[:eid]]
      end
    end

    def get_emp_for_task(task_id)
      gettask = @tasks.values.find do |task|
        task.id == task_id
      end

      @employees[gettask.emp_id]
    end

    ###########################
    ## Employee CRUD Methods ##
    ###########################



    ###########################
    ## PROJECT CRUD Methods  ##
    ###########################

    def create_project(name)
      proj = Project.new(name)
      @project_list[proj.id] = proj
      proj
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

    def show_projects_for_emp(employee_id)
      emp_id_with_proj = @memberships.select do |hash|
         hash[:eid] == employee_id.to_i
          #iterate through array, get hash
          # check if the value of the has is employee_id
          # emp_id_with_proj should return an array with the hashes
      end # with the key :eid pointing to the employee id
      emp_id_with_proj.map do |memb|
        @project_list[memb[:pid]] # map returns array
      end # go through project_list hash, with the project id key, getting all projects with same id
    end

    ###########################
    ## PROJECT CRUD Methods  ##
    ###########################



    ###########################
    ##   TASK CRUD Methods   ##
    ###########################

    def create_task(pid,data)
      # will assign a task, to project, based on pid
      # create task takes in an id. that was a string
      task = Task.new(pid.to_i,data)
      #@task_project[]
      @tasks[task.id] = task
      task
    end


    def get_task(tid)
      @tasks[tid.to_i]
    end

    def delete_task(tid)
      @tasks.delete(tid.to_i)
      @tasks
    end

     def update_tasks(tid, pid, eid, descr, priority_num)
      task = @tasks[tid.to_i]
      task.descr = descr
      task.proj_id = pid
      task.emp_id = eid
      task.priority_num = priority_num
    end

    #########TRY AND GET THE METHOD TO RUN THIS WAY LATER##DBSPEC 105
    # def update_tasks(tid, data)
    #   task = @tasks[tid]
    #   descr = data[:descr]
    #   pid = data[:project_id]
    #   eid = data[:eid]
    #   priority_num = data[:priority_num]
    #   task.descr = descr
    #   task.proj_id = pid
    #   task.emp_id = eid
    #   task.priority_num = priority_num
    # end

    def assign_task_emp(task_id,employee_id)
      updating_task = @tasks[task_id.to_i]
      updating_task.emp_id = employee_id.to_i
      updating_task
    end

    def get_tasks_for_emp(employee_id)
      @tasks.values.select do |task| # values gets the keys as an array
        task.emp_id == employee_id.to_i # array is task objects
      end # task.emp_id is accessing the task employee id, if equal to parameter
    end   # will select it, and add it to an array, which is returned

    def mark_task_complete(task_id)
      thetask = @tasks.values.find { |task|
        task.id == task_id.to_i
      }
      thetask.complete = true
    end

    def get_task_for_proj(project_id)
      #@task is a hash, you want to search through it's value(task object)
      @tasks.values.select do |task| # selct on task array
        task.proj_id == project_id  #if attribute project id of task is === to paramter select it
      end
    end


    def remaining_task_emp(employee_id)
      task_for_emp = @tasks.values.select do  |task|
        task.emp_id == employee_id.to_i && task.complete == false
      end
    end

    def completed_task_emp(employee_id)
      @tasks.values.select do |task|
        task.emp_id == employee_id.to_i && task.complete == true
      end
    end

    def remaining_task_proj(project_id)
      @tasks.values.select do |task|
        task.proj_id == project_id.to_i && task.complete == false
      end
    end

    def completed_task_proj(project_id)
      @tasks.values.select do |task|
        task.proj_id == project_id.to_i && task.complete == true
      end
    end

    ###########################
    ##   TASK CRUD Methods   ##
    ###########################

    def add_membership(employee_id,project_id)
      @memberships << {:eid => employee_id.to_i, :pid =>project_id.to_i}
    end



    def testing
      @db
    end


##########################################################
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



