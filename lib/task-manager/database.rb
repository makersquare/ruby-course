require 'pry-debugger'

class TM::DB

  attr_reader :tasks, :projects, :project_count, :task_count, :employees, :employee_count, :employees_projects
  def initialize
    @projects = {}
    @project_count = 0
    @tasks = {}
    @task_count = 0
    @employees = {}
    @employee_count = 0
    @employees_projects = {}
    # @employees_projects = {1 => {id: 1, pid: 1, eid: 2}, 2=>...}
    @emp_proj_count = 0
    @employees_tasks = {}
    # @employees_tasks = {1 => {id: 1, tid: 1, eid: 2}, 2=>...}
    @emp_task_count = 0
  end

# Projects ---------------------------------------

  def create_project(data)
    @project_count += 1
    data[:id] = @project_count
    @projects[data[:id]] = data
    return TM::DB.build_project(data)
  end

  def get_project(id)
    data = @projects[id]
    if !data.nil?
      return TM::DB.build_project(data)
    end
  end

  def update_project(id, data)
    old_data = @projects[id]
    old_data.merge!(data)
    return TM::DB.build_project(old_data)
  end

  def destroy_project(id)
    @projects.delete(id)
    @tasks.each do |x,y|
      @tasks.delete(x) if @tasks[x][:pid] = id
    end
  end

  # Hash of complete tasks sorted by date created
  def complete_tasks(pid)
    complete = @tasks.select{|x,y| @tasks[y][:pid] == pid && @tasks[y][:complete]}
    complete = complete.sort_by {|k,v| v[:date]}
    complete
  end

  # Hash of incomplete tasks sorted by priority number and then duedate
  def incomplete_tasks(pid)
    incomplete = @tasks.select{|x,y| @tasks[y][:pid] == pid && @tasks[y][:complete] == false}
    incomplete = incomplete.sort_by {|k,v| [v[:pnum],v[:duedate]]}
    incomplete
  end

  # Don't need to sort overdue tasks, only use for percentage
  def overdue_tasks(pid)
    overdue = @tasks.select{|x,y| @tasks[y][:pid] == pid && @tasks[y][:complete] == false && @tasks[y][:duedate] < today}
    overdue
  end

  def percent_done(pid)
    complete = TM::DB.db.complete_tasks(pid)
    incomplete = TM::DB.db.incomplete_tasks(pid)
    percent_complete = 0
    percent_complete = complete.length/(complete.length+incomplete.length)*100 if complete.length != 0
    percent_complete
  end

  def percent_overdue(pid)
    over = TM::DB.db.overdue_tasks(pid)
    incomplete = TM::DB.db.incomplete_tasks(pid)
    percent_overdue = 0
    percent_overdue = (overdue.length/incomplete.length)*100 if incomplete.length != 0 && overdue.length != 0
    percent_overdue
  end

  def list_projects
    array = []
    @projects.each do|x,y|
      percent_done = TM::DB.db.percent_done(x)
      percent_overdue = TM::DB.db.percent_overdue(x)
      array << {pid: y[:pid],name: y[:name],percent_done: percent_done,percent_over: percent_overdue}
    end
    array
  end

  def self.build_project(data)
    TM::Project.new(data[:name], data[:id])
  end

# Tasks ---------------------------------------

  def create_task(data) #pid, des, pnum, duedate
    @task_count += 1
    data[:tid] = @task_count
    data[:complete] = false
    t = Time.now
    data[:date] = "#{t.year} #{t.month} #{t.day}"
    @tasks[@task_count] = data
    return TM::DB.build_task(data)
  end

  def get_task(tid)
    data = @tasks[tid]
    if !data.nil?
      return TM::DB.build_task(data)
    end
  end

  def update_task(id, data)
    old_data = @tasks[id]
    old_data.merge!(data)
    return TM::DB.build_task(old_data)
  end

  def destroy_task(id)
    @tasks.delete(id)
  end

  def self.build_task(data)
    TM::Task.new(data[:pid], data[:tid], data[:desc], data[:pnum], data[:duedate], data[:date], data[:complete])
  end

  # Can assign only one employee to task, but employees can have multiple tasks
  def add_emp_to_task(tid, eid)
    old_data = @tasks[tid]
    if old_data[:eid].nil?
      old_data[:eid] = eid
      return TM::DB.build_task(old_data)
    end
  end

# Employees ---------------------------------------

  def create_employee(data)
    @employee_count += 1
    data[:eid] = @employee_count
    @employees[@employee_count] = data
    return TM::DB.build_employee(data)
  end

  def get_employee(eid)
    data = @employees[eid]
    if !data.nil?
      return TM::DB.build_employee(data)
    end
  end

  def update_employee(eid, data)
    old_data = @employees[eid]
    old_data.merge!(data)
    return TM::DB.build_employee(old_data)
  end

  def destroy_employee(eid)
    @employees.delete(eid)
  end

  def list_employees
    array = []
    @employees.each do|x,y|
      array << {eid: y[:eid],name: y[:name]}
    end
    array
  end

  def self.build_employee(data)
    TM::Employee.new(data[:name], data[:eid])
  end

# Employees_Projects ---------------------------------------

  def create_proj_emp(data)
    @emp_proj_count += 1
    data[:id] = @emp_proj_count
    @employees_projects[data[:id]] = data
    return {name: @employees[data[:eid]][:name],project: @projects[data[:pid]][:name]}
  end

  # Lists projects for an employee
  def get_proj_by_emp(eid)
    data = []
    @employees_projects.each do |x,y|
      if y[:eid] == eid
        percentage = TM::DB.db.projects_tasks(y[:pid])
        data << {pid: y[:pid], name: @projects[y[:pid][:name]], percent_done: percentage[:percent_done], percent_over: percentage[:percent_over]}
      end
    end
    data
  end

  # Lists employees for a project
  def get_emp_by_proj(pid)
    data = []
    @employees_projects.each do |x,y|
      if y[:pid] == pid
        data << {eid: y[:eid], name: y[:name]}
      end
    end
    data
  end

  def destroy_proj_emp(pid, eid)
    @employees_projects.each do |x,y|
      if y[:eid] == eid && y[:pid] == pid
        @employees_projects.delete(x)
      end
    end
  end

# Employees_Tasks ---------------------------------------

  def create_task_emp(data)
    @emp_task_count += 1
    data[:id] = @emp_task_count
    @employees_tasks[data[:id]] = data
    return {name: @employees[data[:eid]][:name],task: @tasks[data[:tid]][:desc]}
  end

  # Lists incomplete tasks for an employee
  def get_inctask_by_emp(eid)
    data = []
    @employees_tasks.each do |x,y|
      if y[:eid] == eid && !@tasks[y[:tid]][:complete]
        data << {tid: y[:tid], desc: @tasks[y[:tid][:desc]], duedate: @tasks[y[:tid]][:duedate], pnum: @tasks[y[:tid]][:pnum]}
      end
    end
    data
  end

  # Lists complete tasks for an employee
  def get_comptask_by_emp(eid)
    data = []
    @employees_tasks.each do |x,y|
      if y[:eid] == eid && @tasks[y[:tid]][:complete]
        data << {tid: y[:tid], desc: @tasks[y[:tid]][:desc], date: @tasks[y[:tid]][:date]}
      end
    end
    data
  end

  # Lists employees for a task
  def get_emp_by_task(tid)
    data = []
    @employees_tasks.each do |x,y|
      if y[:tid] == tid
        data << {eid: y[:eid], name: y[:name]}
      end
    end
    data
  end

  def destroy_task_emp(tid, eid)
    @employees_tasks.each do |x,y|
      if y[:eid] == eid && y[:tid] == tid
        @employees_tasks.delete(x)
      end
    end
  end

# Create Class instance -----------------------------

  def self.db
    @__db_instance ||= TM::DB.new
  end

end
