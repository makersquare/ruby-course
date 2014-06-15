require 'time'

class TM::Task
  attr_accessor :tid, :description, :priority, :status, :creation_date
  @@tasks = []

  def initialize(priority, description)
    @description = description
    @priority = priority
    @tid = @@tasks.size
    @@tasks << self
    @status = "incomplete"
    @creation_date = Time.now
  end

  def mark_complete
    @status = "complete"
  end
end
