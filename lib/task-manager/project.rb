
class TM::Project
  attr_reader :name, :id
  attr_accessor :tasks
  @@counter = 0
  def initialize(name)
    @name = name
    @@counter += 1
    @id=@@counter
    @tasks = []
  end

  def add_task(task)
    @tasks.push(task)
  end

  def complete(task_id)
    target = @tasks.find{|task| task.task_id == task_id}
    target.status = "completed"
  end


end
