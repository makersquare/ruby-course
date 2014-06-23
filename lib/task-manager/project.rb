require 'time'
require 'pg'

class TM::Project
  attr_accessor :name, :pid

  def initialize(name, creation_date=nil)
    project = TM.orm.show_project
    @pid = project[0]
    @name = project[1]
    @creation_date = project[2]
  end

  def self.list_projects
    TM.orm.list_projects
    # @@projects.each_with_index { |i,idx| puts "PID #{idx}: #{i.name}" }
  end

  def self.add_project(name)
    TM.orm.add_project(name)
  end

  def self.list_project_tasks(pid)
    TM.orm.list_project_tasks(pid)
  end

  def self.list_incomplete_tasks(pid)
    TM.orm.list_incomplete_tasks(pid)
    # @tasks.sort_by! { |i| [i.priority, i.creation_date] }
    # @tasks.select { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" if i.status == 'incomplete' }
  end

  def self.list_completed_tasks(pid)
    TM.orm.list_completed_tasks(pid)
    # @tasks.sort_by! { |i| i.creation_date }
    # @tasks.select { |i| puts "TID #{i.tid}: #{i.description}" if i.status == 'complete' }
  end

  def self.list_project_staffing(pid)
    TM.orm.list_project_staffing(pid)
  end

  def self.update_employee_project(pid, eid)
    TM.orm.update_employee_project(pid, eid)
  end

  def self.add_task(priority, description, pid)
    TM.orm.add_task(priority, description, pid)
  end

  def self.update_employee_task(eid, tid)
    TM.orm.update_employee_task(eid, tid)
  end

  def self.update_complete(tid)
    TM.orm.update_complete(tid)
  end

  def self.list_employees
    TM.orm.list_employees
  end

  def self.add_employee(name)
    TM.orm.add_employee(name)
  end

  def self.list_employee_projects(eid)
    TM.orm.list_employee_projects(eid)
  end

  def self.list_employee_tasks(eid)
    TM.orm.list_employee_tasks(eid)
    # employee_tasks = @tasks.map { |i| i if i[4] == eid }
  end

  def self.list_employee_history(eid)
    TM.orm.list_employee_history(eid)
    # @tasks.sort_by! { |i| [i[1], i[6]] }
    # puts @tasks.map { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" }
  end
end
