
class TM::Task

    attr_accessor :tid, :desc, :pnum, :complete, :pid, :date, :duedate

  def initialize(pid, tid, desc, pnum, duedate, date, complete)
    @pid = pid
    @date = date
    @pnum = pnum
    @tid = tid
    @desc = desc
    @duedate = duedate
    @complete = complete
  end

end
