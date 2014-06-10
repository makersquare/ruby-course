
class TM::Project
  attr_reader :name, :id, :tasks
  @@ids=[]
  def initialize(name)
  @name=name
  @@ids<<self
  @id=@@ids.length
  @tasks=[]
  end

  def add_task(description,priority)
    @tasks<<TM::Task.new(@id,description,priority,@tasks.length)
    @tasks.length-1
  end
  def complete_task(id)
    @tasks[id].change_status
  end
  def list_complete_tasks
    complete = @tasks.select{|arg| arg.completed}
    complete.sort!{|arg1,arg2| arg1.date<=>arg2.date}
  end
  def list_incomplete_tasks
    incomplete = @tasks.select{|arg| !arg.completed}
    incomplete.sort!{|arg1,arg2| arg1.date<=>arg2.date}
    incomplete.sort!{|arg1,arg2| arg1.priority<=>arg2.priority}
  end
end
