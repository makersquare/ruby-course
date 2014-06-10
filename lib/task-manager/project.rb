
class TM::Project
  attr_reader :name, :id, :tasks
  def initialize(name)
  @@ids=[]
  @name=name
  @id=@@ids.count
  @@ids<<self
  @tasks=[]
  end

  def add_task(description,priority)
    @tasks<<TM::Task.new(@id,description,priority,@tasks.length)
  end
end
