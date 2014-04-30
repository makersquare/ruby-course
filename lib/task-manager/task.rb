
class TM::Task

    attr_reader :date
    attr_accessor :tid_counter, :tid, :description, :pnum, :complete, :pid

    @@tid_counter = 0
  def initialize(pid, description, pnum)
    @pid = pid
    @date = Time.now
    @pnum = pnum
    @@tid_counter += 1
    @tid = @@tid_counter
    @description = description
    @complete = false
  end

  def self.reset_class_variables
    @@tid_counter = 0
  end
end
