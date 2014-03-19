
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
    task.project_id = @id
    @tasks.push(task)
  end

  def complete(task_id)
    target = @tasks.find{|task| task.task_id == task_id}
    target.status = "completed"
  end

  def retrieve_completed
    array = @tasks.select{|task| task.status == "completed"}
    array.sort_by!{|task| task.task_id}
  end

end
