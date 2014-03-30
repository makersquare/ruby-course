module TM
  class DB
    attr_accessor :projects, :tasks, :employees, :memberships

    def initialize
      @projects = {}
      @tasks = {}
      @employees = {}
      @memberships = []
    end


    def create_project(project_name)
      new_project = Project.new(project_name)
      new_project_id = new_project.id
      @projects[new_project_id] = new_project

      return new_project

    end

    def create_employee(name)
      employee = Employee.new(name)
      employees[employee.id] = employee
    end

    def get_project(pid)
      requested_project = projects[pid]
      requested_project
    end

    def get_employee(eid)
      @employees[eid]
    end

    def get_task(tid)
      @tasks[tid]
    end

    def list_employees
      employees = @employees.values
    end

    def get_project_membership(pid)

      project_employees = []
      @memberships.select do |membership|
        membership.select do |k, v|
          if k == pid
            project_employees.push(v)
          end
        end
      end
      project_employees
    end

    def get_employee_membership(eid)
      employee_projects = []
      @memberships.select do |membership|
        membership.select do |k, v|
          if v == eid
            employee_projects.push(k)
          end
        end
      end
      employee_projects
    end

    def add_task_to_project(description, priority, pid)
      task = Task.new(description, priority, pid)
      @tasks[task.id] = task

      @tasks[task.id]
    end

    def assign_task(tid, eid)
      task = get_task(tid)
      task.eid = eid
      task

    end

    def mark_task_complete(tid)
      task = get_task(tid)
      task.complete = true

      task
    end

    def assign_employee_to_project(pid, eid)
      project = get_project(pid)
      employee = get_employee(eid)
      @memberships.push({project.id => employee.id})
    end

    def show_completed_tasks(pid)
     completed_tasks = @tasks.values.select {|task| task.pid == pid && task.complete == true}

     completed_tasks
    end

    def show_remaining_tasks(pid)
     remaining_tasks = @tasks.values.select {|task| task.pid == pid && task.complete == false}

     remaining_tasks
    end


    def get_employee_projects(eid)
      employee_project_ids = get_employee_membership(eid)
      project_list = employee_project_ids.map {|pid| @projects[pid]}

      project_list
    end

    def show_remaining_employee_tasks(eid)
      remaining_employee_tasks = @tasks.values.select {|task| task.eid == eid && task.complete == false}

      remaining_employee_tasks
    end

    def show_completed_employee_tasks(eid)
      completed_employee_tasks = @tasks.values.select {|task| task.eid == eid && task.complete == true}
    end

  end
end
