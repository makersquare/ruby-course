
class TM::Project
attr_reader :name, :id
attr_accessor :tasks

  @@project_counter = 0

  def initialize(name)
    @name = name
    @@project_counter += 1
    @id = @@project_counter
    @tasks = []
  end

  def add_task(task)
    task.project_id = @id
    @tasks.push(task)
  end

  def task_completed(task_id)
    target = @tasks.find{ |task| task.id == task_id}
    target.status = "completed"
    target
  end

  def retrieve_completed
    array = @tasks.select {|task| task.status == "completed"}
    array.sort_by!{|task| task.id}
  end

end

