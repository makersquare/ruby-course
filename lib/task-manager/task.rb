
class TM::Task
  attr_reader :description, :priority, :taskid
  attr_accessor :status

  def initialize(projectid = TM::Project.id, description, priority,taskid)
    @projectid = projectid
    @description = description
    @priority = priority
    @status = "incomplete"
    @taskid = taskid
  end

  def taskcompleted

  end

end


# def initialize( toppingsArray = [ Topping.new("cheese") ] )
#     @toppings = toppingsArray
#   end
