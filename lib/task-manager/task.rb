
class TM::Task

    attr_reader :date, :duedate
    attr_accessor :tid_counter, :tid, :description, :pnum, :complete, :pid, :tasks, :completed_tasks

    @@tid_counter = 0
    @@tasks = []
    @@completed_tasks = []
  def initialize(pid, description, pnum, duedate)
    t = Time.now
    @pid = pid
    @date = "#{t.year} #{t.month} #{t.day}"
    @pnum = pnum
    @@tid_counter += 1
    @tid = @@tid_counter
    @description = description
    @complete = false
    @duedate = duedate
    @@tasks << self
  end

  def self.reset_class_variables
    @@tid_counter = 0
    @@tasks = []
    @@completed_tasks = []
  end

  def self.list_tasks
    @@tasks
  end

  def self.mark_complete(taskid)
    task = @@tasks.select{|task| task.tid == taskid}
    task = task[0]
   if task.complete == true
      puts "Task is already complete"
    else
      task.complete = true
      @@completed_tasks << task
      puts "The task has been marked as complete!"
    end
  end

  def self.completed_tasks(projid)
    task = @@completed_tasks.select{|task| task.pid == projid}
    task.sort_by! {|task| task.date}
    task
  end

  def self.incomplete_tasks(projid)
    task = @@tasks.select{|task| task.pid == projid && task.complete == false}
    task.sort_by! {|t| [t.duedate, t.pnum, t.date]}
    task
  end

end
