
require 'pry-debugger'

class TM::Project
    attr_accessor :name, :pid, :complete

    def initialize(name, pid)
      @name = name
      @complete = false
      @pid = pid
    end

    # def self.reset_class_variables
    #   @@id_counter = 0
    #   @@projects = []
    # end

    # def self.list_projects
    #   @@projects
    # end

    def edit_project()
    end

    def self.percentage_complete(projid)
      task_done = TM::Task.completed_tasks(projid.to_i)
      task_do = TM::Task.incomplete_tasks(projid.to_i)
      total = TM::Task.list_tasks
      percent_done = 0
      percent_overdue = 0
      percent_done = task_done.length/total.length*100 if task_done.length > 0
      t = Time.now
      today = "#{t.year} #{t.month} #{t.day}"
      over = task_do.select {|task| task.duedate < today}
      over = over.length
      percent_overdue = over/total.length*100 if over > 0
      "#{percent_done}%\t#{percent_overdue}%"
    end

end
