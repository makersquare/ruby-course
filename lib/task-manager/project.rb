require 'pry-byebug'

class TM::Project
  attr_reader :name, :pid

  @@counter = 0
  @@projects = []

  def initialize name
    @name = name
    @pid = @@counter
    @pid += 1
    @@projects << self
  end

  def self.get_complete_tasks pid
    task_array = TM::Task.get_tasks.select do |task|
      task.pid == pid && task.status == :complete
    end
    task_array.sort_by {|t| t.time}
    task_array.each do |t|
      puts "Task #{t.description} with a priority of #{t.priority} was created at #{t.time}"
    end
  end

  def self.get_incomplete_tasks pid
    # p TM::Task.get_tasks
    task_array = TM::Task.get_tasks.select do |task|
      task.pid == pid && task.status == :incomplete
    end
    task_array.sort_by {|t| puts [t.priority, t.time]}
  end

  def self.project_list
    @@projects.each do |project|
      puts "List of current projects: #{project.name} pid: #{project.pid}"
    end
  end
end
