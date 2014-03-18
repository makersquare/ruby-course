
class TM::Task
  attr_reader :description
  attr_reader :priority
  def initialize(projectid = TM::Project.id ,description,priority)
    @projectid = projectid
    @description = description
    @priority = priority
  end

end


# def initialize( toppingsArray = [ Topping.new("cheese") ] )
#     @toppings = toppingsArray
#   end
