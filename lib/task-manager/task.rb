
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
