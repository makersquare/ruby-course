
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

end
