
class TM::Task
  attr_reader :description, :priority, :taskid, :creationtime
  attr_accessor :status, :tasklist, :projectid

  def initialize(projectid = TM::Project.id, description, priority,taskid)
    @projectid = projectid
    @description = description
    @priority = priority
    @status = "incomplete"
    @taskid = taskid
    @creationtime = Time.now
  end


  def done(tasklist, task_completed)

    tasklist.each do |task|
      if task == task_completed
        return task.status = "completed"
      end
    end

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

