
class TM::Task
  attr_reader :description, :priority, :taskid
  attr_accessor :status, :tasklist
  @@tasklist = []
  def initialize(projectid = TM::Project.id, description, priority,taskid)
    @projectid = projectid
    @description = description
    @priority = priority
    @status = "incomplete"
    @taskid = taskid

  end

  def self.tasklist
    @@tasklist
  end

  def self.add(task)
    @@tasklist << task
    return @tasklist
  end





  # def taskcompleted(taskid)
  #   if newtask.taskid == taskid
  #      newtask.status = "completed"
  #   else
  #      return "task not found"
  #   end
  # end

 end


# def initialize( toppingsArray = [ Topping.new("cheese") ] )
#     @toppings = toppingsArray
#   end

