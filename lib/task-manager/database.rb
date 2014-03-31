module TM

  # Our singleton getter
  def self.db
    @__db_instance ||= Database.new
  end

  # Our singleton class
  class Database
      # Database stuff
    attr_reader :projects, :tasks, :employees

    def initialize
      @projects = {}
      @tasks = {}
      @employees = {}
      @membership = {}
    end

    def add_project(name)
      proj = TM::Project.new(name)
      @projects[proj.project_id] = proj
      proj
    end

    def create_task(pid, description, priority = 3)
      task = TM::Task.new(pid, description, priority)
      @tasks[task.task_id] = task
      task
    end

    def add_employee(name, tid)
      emp = TM::Employee.new(name)
      @employees[emp.employee_id] = emp
      task = @tasks[tid]
      task.employee = emp.employee_id
      emp
    end

    def get_project(id)
     @projects[id]
    end

    def get_task(id)
      @tasks[id]
    end

    def get_employee(id)
      @employees[id]
    end

    def mark_complete(tid)
      task = get_task(tid)
      task.status = 'complete'
    end

    def get_completed(pid)
      pid_tasks = @tasks.values.select {|task| task.project_id == pid}
      completed = pid_tasks.select {|task| task.status == 'complete'}
      return completed.sort_by {|task| task.priority}
    end

    def get_incompleted(pid)
      pid_tasks = @tasks.values.select {|task| task.project_id == pid}
      completed = pid_tasks.select {|task| task.status == 'incomplete'}
      return completed.sort_by {|task| task.priority}
    end


  end
end
