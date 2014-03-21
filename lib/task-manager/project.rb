
class TM::Project
  @@counter = 0

  attr_reader :name, :id
  attr_accessor :tasks

  def initialize(name)
    @name = name
    @@counter += 1
    @id = @@counter
    @tasks = []
  end

  def add_task(task)
    task.project_id = @id
    @tasks << task
  end

  def complete(id)
     completed_task = @tasks.find { |task| task.id == id }
     completed_task.complete = true
  end

  def retrieve_completed_tasks
      completed_tasks = @tasks.select { |task| task.complete == true }
      completed_tasks.sort! { |x,y| y.date_created <=> x.date_created}
  end

  def retrieve_incomplete_tasks
      incompleted_tasks = @tasks.select { |task| task.complete == false }
      incompleted_tasks.sort! { |x,y| [x.date_created <=> y.date_created, x.priority <=> y.priority]}
  end


end
