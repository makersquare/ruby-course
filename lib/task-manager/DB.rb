module TM
  def self.DB
    @__db  ||= DB.new
  end

  class DB
  attr_accessor :projects, :tasks, :employees, :memberships

  def initialize
    @projects = {}
    @tasks = {}
    @employees = {}
    @memberships = []
  end

  def get_task(tid)
    @tasks[tid]
  end

  def get_project(pid)
    @projects[pid]
  end

  def get_employee(eid)
    @employees[eid]
  end

  def get_project_membership(pid)
    project_employees = []
    @memberships.select do |hash|
      hash.select do |key, value|
        if key == pid
          project_employees << value
        end
      end
    end
    project_employees
  end

 def get_emp_membership(eid)
    employees_project = []
    @memberships.select do |hash|
      hash.select do |key, value|
        if value == eid
          employees_project << key
        end
      end
    end
    employees_project
  end

  def create_project(name)
    project = Project.new(name)
    @projects[project.id] = project
    return project
  end

  def create_task(description)
    task = Task.new(description)
    @tasks[task.id] = task
    return task
  end

  def create_employee(name)
    emp = Employee.new(name)
    @employees[emp.id] = emp
  end

  def add_task_to_project(description, priority=nil, pid)
    task = Task.new(description, priority, pid)
    @tasks[task.id] = task
  end

  def assign_task(tid, eid)
    task = get_task(tid)
    task.eid = eid
    return task
  end

  def assign_emp_to_project(eid, pid)
    emp = get_employee(eid)
    proj = get_project(pid)
    @memberships << {proj.id => emp.id}
    @memberships
  end

  def task_complete(tid)
    task = get_task(tid)
    task.complete = true
  end

  def show_completed_tasks(pid)
    completed_tasks = @tasks.values.select { |task|
      task.pid == pid && task.complete == true }
  end

  def show_remaining_tasks(pid)
    remaining_tasks = @tasks.values.select { |task|
      task.pid == pid && task.complete == false }
  end

  def get_employee_project(eid)
    pids = get_emp_membership(eid)
    pids.map { |pid| @projects[pid] }
  end

  def remaining_employee_tasks(eid)
    remaining_tasks_then_projects = []
    remaining_tasks = @tasks.values.select { |task| task.eid == eid && task.complete == false}
    remaining_projects = remaining_tasks.map { |task| task.pid }
    projects = remaining_projects.map { |pid| @projects[pid].name}
  end

  end
end
