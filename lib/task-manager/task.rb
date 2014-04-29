
class TM::Task

    attr_reader :pid
    attr_accessor :tid_counter, :tid, :description, :pnum

    @@tid_counter = 0
    @@projects = []
  def initialize(pid, description, pnum)
    @@pid = pid
    @description = description
    @pnum = pnum
    @@tid_counter += 1
    @tid = @@tid_counter
  end
end
