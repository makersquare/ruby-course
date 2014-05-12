
class TM::Task

    attr_reader :date, :duedate
    attr_accessor :tid, :desc, :pnum, :complete, :pid

  def initialize(pid, tid, desc, pnum, duedate, date, complete)
    @pid = pid
    @date = date
    @pnum = pnum
    @tid = tid
    @desc = desc
    @duedate = duedate
    @complete = complete
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
    task = @@completed_tasks.select{|task| task.pid == projid.to_i}
    task.sort_by! {|task| task.date}
    task
  end

  def self.incomplete_tasks(projid)
    task = @@tasks.select{|task| task.pid == projid.to_i && task.complete == false}
    task.sort_by! {|t| [t.duedate, t.pnum, t.date]}
    task
  end

end
