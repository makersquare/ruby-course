
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
    complete=@tasks.select{|arg| arg.completed}
  end
  def list_incomplete_tasks
    incomplete=@tasks.select{|arg| !arg.completed}
  end

end
