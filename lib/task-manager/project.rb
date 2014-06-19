require 'time'
require 'pg'

class TM::Project
  attr_accessor :name, :pid, :tasks

  @@projects = []

  def initialize(name=nil)
    @name = name
    @tasks = [] ##add to tasks table of db
    @@projects << self
  end

  def add_task(priority, description)
    task = TM::Task.new(priority, description)
    @tasks << task
    TM.db.add_task(priority, description, pid, eid=nil, status='incomplete', creation_date=Time.now)
  end

  def list_employee_tasks
    TM.db.list_employee_tasks(eid)
  end

  def list_employee_projects(eid)
    TM.db.list_employee_tasks(eid)
  end

  def list_all_tasks
    TM.db.list_all_tasks
    # puts @tasks.map { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" }
  end

  def list_completed_tasks
    TM.db.list_completed_tasks
    # @tasks.sort_by! { |i| i.creation_date }
    # @tasks.select { |i| puts "TID #{i.tid}: #{i.description}" if i.status == 'complete' }
  end

  def list_incomplete_tasks
    TM.db.list_incomplete_tasks
    # @tasks.sort_by! { |i| [i.priority, i.creation_date] }
    # @tasks.select { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" if i.status == 'incomplete' }
  end

  def self.list_projects
    TM.db.list_projects
    # @@projects.each_with_index { |i,idx| puts "PID #{idx}: #{i.name}" }
  end

end
