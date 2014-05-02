
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :id_counter, :pid, :projects, :completed_tasks, :tasks

    @@id_counter = 0
    @@projects = []
    def initialize(name)
      @name = name
      @@id_counter += 1
      @pid = @@id_counter
      @@projects << self
    end

    def self.reset_class_variables
      @@id_counter = 0
      @@projects = []
    end

    def self.list_projects
      @@projects
    end

    def self.percentage_complete(projid)
      task_done = TM::Task.completed_tasks(projid) 
      task_donel = task_done.length
      task_do = TM::Task.incomplete_tasks(projid)
      task_dol = task_do.length
      sum = task_donel + task_dol
      total = TM::Task.list_tasks
      total == total.length
      if sum == 0
        "0%\t0%"
      elsif task_do == 0
        percent_done = task_donel/total*100
        "#{percent_done}%\t0%"
      elsif task_done == 0
        t = Time.now
        today = "#{t.year} #{t.month} #{t.day}"
        over = task_do.select {|task| task.duedate < today}
        over = over.length
        percent_overdue = over/total*100
        "0%\t#{percent_overdue}%"
      else
        percent_done = task_donel/total*100
        t = Time.now
        today = "#{t.year} #{t.month} #{t.day}"
        over = task_do.select {|task| task.duedate < today}
        over = over.length
        percent_overdue = over/total*100
        "#{percent_done}%\t#{percent_overdue}%"
      end
    end

end
