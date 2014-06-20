require 'time'
require 'pg'

class TM::Project
  attr_accessor :name, :pid, :tasks

  # @@projects = []

  def initialize(name=nil)
    # TM.orm
    @name = name
    @pid = pid
    @tasks = tasks
    # @tasks = TM.orm.list_all_tasks
    # @projects = TM.orm.list_projects
    # @employees = TM.orm.list_all_employees
  end

  def self.list_projects
    TM.orm.list_projects
    # @@projects.each_with_index { |i,idx| puts "PID #{idx}: #{i.name}" }
  end

  def self.add_project(name)
    new_project = TM.orm.add_project(name)
    ###puts project added...
  end

  def self.list_incomplete_tasks
    TM.orm.list_incomplete_tasks
    # @tasks.sort_by! { |i| [i.priority, i.creation_date] }
    # @tasks.select { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" if i.status == 'incomplete' }
  end

  def self.list_completed_tasks
    TM.orm.list_completed_tasks
    # @tasks.sort_by! { |i| i.creation_date }
    # @tasks.select { |i| puts "TID #{i.tid}: #{i.description}" if i.status == 'complete' }
  end

  def self.list_project_staffing(pid)
    TM.orm.list_project_staffing(pid)
  end

  def self.update_employee(pid, eid)
    TM.orm.recruit_employee(pid, eid)
  end

  def self.add_task(priority, description, pid)
    TM.orm.add_task(priority, description, pid)
    ###puts task...added...
  end
  # def self.add_project(name)
  #   new_project = TM.orm.add_project(name)
  #   ###puts project added...
  # end
  def self.add_employee_task(eid, pid, tid)
    TM.orm.assign_task(eid, pid, tid)
  end

  def self.update_complete(pid, tid)
    TM.orm.mark_complete
  end

  def self.list_employees
    TM.orm.list_employees
  end

  def self.add_employee(name)
    TM.orm.add_employee(name)
  end

  def self.list_employee_projects(eid)
    ###join employee to projects
  end

  def self.list_employee_tasks(eid)
    # employee_tasks = @tasks.map { |i| i if i[4] == eid }
  end

  def self.list_employee_history(eid)
    # @tasks.sort_by! { |i| [i[1], i[6]] }
    # puts @tasks.map { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" }
  end
end
