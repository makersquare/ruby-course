
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :id_counter, :pid, :projects, :completed_tasks, :tasks

    @@id_counter = 0
    @@tasks = []
    @@projects = []
    @@completed_tasks = []
    def initialize(name)
      @name = name
      @@id_counter += 1
      @pid = @@id_counter
      @@projects << self
    end

    def self.reset_class_variables
      @@id_counter = 0
      @@projects = []
      @@tasks = []
      @@completed_tasks = []
    end

    def self.list_projects
      @@projects
    end

    def add_task(task)
      @@tasks << task
    end

    def list_tasks
      @@tasks
    end

    def mark_complete(projid, taskid)
      task = @@tasks.select{|task| task.pid == projid && task.tid == taskid} 
      task = task[0]
     if task.complete == true
        puts "Task is already complete"
      else
        task.complete = true
        @@completed_tasks << task
      end
    end

    def completed_tasks(pid)
    end

    def incomplete_tasks(pid)
    end
end
