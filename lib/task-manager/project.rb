
class TM::Project
  attr_reader :name, :id, :tasks

  @@current_id = 1


  def self.current_id=(current_id)
    @@current_id = current_id
  end


  def initialize(name)
    @name = name
    @id = @@current_id
    @@current_id = @@current_id + 1
    @tasks = {}
  end


  def add_task(task)  # takes a task id or a Task object and adds the task to the project hash
    # if a task object has been passed, add it
    if task.is_a?(TM::Task)
      @tasks[task.task_id] = task
    else    # if it's a number, add it using the id
      @tasks[task] = TM::Task.all_tasks[task]
    end
  end

  def mark_as_finished(task_id)
    @tasks[task_id].finished = true
  end



end
