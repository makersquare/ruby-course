
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
    # set task object depending on what has been passed
    if task.is_a?(TM::Task)     #if an object was passed
      task_object = task
    else     # if a task_id was passed
      task_object = TM::Task.all_tasks[task]
    end

    # add the task to the @tasks hash
    @tasks[task_object.task_id] = task_object
  end

  def mark_as_finished(task_id)
    @tasks[task_id].finished = true
  end

  def completed_tasks  #returns completed_tasks in the proper order
    completed_tasks = @tasks.select { |k,v| v.finished? == true }.values
    completed_tasks.sort! { |a,b| (a.priority <=> b.priority) == 0 ? (a.creation_date <=> b.creation_date) : (b.priority <=> a.priority) }
    #completed_tasks.sort! { |a,b| -a.priority, a.creation_date <=> -b.priority, b.creation_date }
  end



end
