require 'time'

class TM::Project
  attr_accessor :name, :pid, :tasks
  @@projects = []

  def initialize(name=nil)
    @name = name
    @pid = @@projects.size
    @tasks = []
    @@projects << self
  end

  def add_task(priority, description)
    task = TM::Task.new(priority, description)
    @tasks << task
  end

  def list_all_tasks
    puts @tasks.map { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" }
  end

  def list_completed_tasks
    @tasks.sort_by! { |i| i.creation_date }
    @tasks.select { |i| puts "TID #{i.tid}: #{i.description}" if i.status == 'complete' }
  end

  def list_incomplete_tasks
    @tasks.sort_by! { |i| [i.priority, i.creation_date] }
    @tasks.select { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" if i.status == 'incomplete' }
  end

  def list_projs
    @@projects.each_with_index { |i,idx| puts "PID #{idx}: #{i.name}" }
  end

end
