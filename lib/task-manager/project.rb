require 'time'

class TM::Project
  attr_accessor :name, :id, :tasks
  @@id = 0

  def initialize(name=nil)
    @name = name
    @id = @@id + 1
    @@id += 1
    @tasks = []
  end

  def add_task(description, priority)
    task = TM::Task.new(description, priority)
    @tasks << task
  end

  def list_all_tasks
    @tasks.each_with_index { |i,v| puts "Task ID #{v}: #{i.description}" }
  end

  def list_completed_tasks
    @tasks.select { |i| i if i.status == "complete" }.sort_by { |i| i.creation_date }
    #maybe use a "puts" here
  end

  def list_incomplete_tasks
    @tasks.select { |i| i if i.status == "incomplete" }.sort_by { |i| i.priority }
  end

end
