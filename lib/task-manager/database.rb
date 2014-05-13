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
  end

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

  def projects_tasks(pid)
    done = @tasks.select{|x,y| @tasks[x][:pid] == pid && @tasks[x][:complete]}
    not_done = @tasks.select{|x,y| @tasks[x][:pid] == pid && !@tasks[x][:complete]}
    total = done.length + not_done.length
    percent_done = 0
    percent_overdue = 0
    percent_done = done.length/total*100 if done.length > 0
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    over = not_done.select{|x,y| not_done[x][:duedate] < today}
    percent_overdue = over.length/total*100 if over.length > 0
    return {done: done, not_done: not_done, over: over, percent_done: percent_done, percent_over: percent_overdue}
  end

  def self.build_project(data)
    TM::Project.new(data[:name], data[:id])
  end

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

  def give_employees_projects(pid, eid)

  end

  def add_employee_to_task(tid, eid)

  end

  def self.build_employee(data)
    TM::Employee.new(data[:name], data[:eid])
  end

  def self.db
    @__db_instance ||= TM::DB.new
  end

end
