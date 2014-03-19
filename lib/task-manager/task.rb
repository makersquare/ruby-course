
class TM::Task

  attr_reader :taskName, :description, :uniqueTaskId, :creationTime
  attr_accessor :status, :priority
  @@dattime = Time.now

  def initialize(uniqueTaskCounter, taskName='noname', description='no description', priority=1, status='incomplete')
    puts uniqueTaskCounter
    @uniqueTaskId = uniqueTaskCounter
    @taskName  = taskName
    @description = description
    @priority = priority
    @status = status
    @creationTime = @@dattime += 61
  end



end
