

class TM::Project
  attr_reader :uniqueId, :description, :projectName, :taskArray, :completedTaskArray
  attr_accessor :priority
  @@thatUniqueCounter = 100000
  @@uniqueProjectArray = []

  def initialize(name)
    @@thatUniqueCounter += 1
    @uniqueId = @@thatUniqueCounter
    @projectName = name
    @@uniqueProjectArray << self
    @taskArray = []
    @uniqueTaskCounter = -1
  end

  def self.uniqueProjectArray
    @@uniqueProjectArray
  end


  def addTask(name='noname', description='no description', priority=1)
    @uniqueTaskCounter += 1
    newtask = TM::Task.new(@uniqueTaskCounter, name, description, priority)
    @taskArray << newtask
  end

  def changeStatus(thattaskID, newstatus)
    taskArray.each do |index|
      if index.uniqueTaskId == thattaskID
        index.status = newstatus
        return
      end
    end
  end

  def sortTasksbyTime(whichArray)
    whichArray.sort! { |x, y| x.creationTime <=> y.creationTime }
    whichArray.each { |x|
      puts x.creationTime
    }
  end

  def sortTasksbyPriority(whichArray)
    whichArray.sort! { |x, y| (x.priority <=> y.priority) == 0 ? x.creationTime <=> y.creationTime :  y.priority <=> x.priority }
  end

  def grabCompletedTasks
    @taskArray.each { |x|
      if x.priority == "completed"
        @completedTaskArray << x
      end
    }
  end





end
