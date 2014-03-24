require 'singleton'

# made a singleton verion of ProjectList

class TM::DB
  include Singleton

  attr_reader :projects, :tasks, :employees

  # examples
  # proj_employees = @memberships.select do |memb|
  #   memb[:pid] == 1
  # end.map do |memb|
  #   @employees[memb[:eid]]
  # end

  # @employees = { 5 => Emp}
  # @memberships = [{ :eid => 5, :pid => 7 }, { :eid => 5, :pid => 9 }]

  def initialize
    @projects = {}
    @tasks = {}

    @employees = {}
  end

  def create_project(title)
    proj = TM::Project.new(title)
    proj_id = proj.id
    @projects[proj_id] = proj

    proj
  end

  def add_task_to_proj(pid, desc, priority)

    # ensure id and priority are integers
    pid = pid.to_i
    priority = priority.to_i

    proj = @projects[pid]

    added_task = TM::Task.new(pid, desc, priority)

    @tasks[added_task.id] = added_task

    added_task
  end

  def show_proj_tasks_remaining(pid)
    # ensure id is an integer
    pid = pid.to_i

    # binding.pry

    # array of tasks belonging to this pid
    # @tasks.values creates an array from values in @tasks hash
    pid_tasks = @tasks.values.select { |task| task.proj_id == pid }

    incomplete_tasks = pid_tasks.select do |task|
      task.completed == false
    end
  end

  def show_proj_tasks_complete(pid)
    # ensure id is an integer
    pid = pid.to_i

    pid_tasks = @tasks.values.select { |task| task.proj_id == pid }

    completed_tasks = pid_tasks.select { |task| task.completed == true }
  end


  def mark_task_as_complete(tid)
    # ensure id is an integer
    tid = tid.to_i

    @tasks[tid].completed = true

    @tasks[tid]
  end

  #############################
  ## other Task CRUD Methods ##
  #############################

  # create already covered by add_task_to_proj

  def get_task(tid)
    @tasks[tid]
  end

  def update_task(tid, new_description = nil, new_priority = nil)
    task = @tasks[tid]

    task.description = new_description || task.description

    task.priority = new_priority || task.priority
  end

  def delete(tid)
    @tasks.delete(tid)
  end

  ################################
  ## other Project CRUD Methods ##
  ################################


  # create already covered by create_proj

  def get_proj(pid)
    @projects[pid]
  end

  def update_proj(pid, new_name = nil)
    proj = @projects[pid]
    proj.name = new_name || proj.name
  end

  def delete_proj(pid)
    @projects.delete(pid)
  end

  ###########################
  ## Employee CRUD Methods ##
  ###########################

  def create_emp(name)
    emp = TM::Employee.new(name)
    @employees[emp.id] = emp
    emp
  end

  def get_emp(eid)
    @employees[eid]
  end

  def update_emp(eid, new_name)
    emp = @employees[eid]
    emp.name = new_name
    emp
  end

  def delete_emp(eid)
    @employees.delete(eid)
  end
end
