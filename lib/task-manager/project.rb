require 'pry-debugger'

class TM::Project

  @@pid = 0
  @@tasks = []
  @@projects = []

  attr_accessor :project_name, :pid, :tasks, :completed_tasks, :task, :projects

  def initialize(project_name, pid=0)
    @project_name = project_name
    @@pid += 1
    @pid = @@pid
    @tasks = []
    @completed = []

         # TM::Task.new([name, @@PID])
  end

  # def add_task(priority, description)
  #   task = TM::Task.new(priority, description, @pid)
  #   @tasks << task
  # end

  def self.reset_class_variable
    @@pid = 0
    @@tasks = []
    @@projects = []
  end


    # this is equivalent to the below
    # completed = []
    # TM::Task.tasks.each do |task|
    #   if task.complete == true && task.pid == self.pid
    #     completed << task
    #   end
    # end

    # completed
  def completed_tasks
    completed = TM::Task.tasks.select do |task|
      task.complete == true && task.pid == self.pid
    end
    completed.sort_by{|task| task.time}
    completed
  end

# project1 = TM::Project.new("Coding")
# project1.completed_tasks

  def incomplete_tasks
    incomplete = TM::Task.tasks.select do |task|
      task.complete == false && task.pid == self.pid
    end
    #array arg that sorts incomplete tasks by prio
  end


end

# @project1 = TM::Project.new("Fix-up house")
# @project2 = TM::Project.new("Go to the grocery store")
