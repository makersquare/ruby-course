
class TM::Project
  attr_reader :name, :id

  @@counter = 0

  def initialize name
    @name  = name
    @id    = @@counter += 1
    @tasks = [ ]
  end

  def new_task(description, priority)
    task = TM::Task.new(description, priority, id)
    @tasks << task
    task
  end

  def incompleted_tasks
    tasks = @tasks.select {|task| task.complete? == false}

    tasks.sort_by! { |task| [task.priority, task.created_at] }
  end

  def completed_tasks
    tasks = @tasks.select {|task| task.complete? == true}

    tasks.sort_by! { |task| [task.priority, task.created_at] }
  end
end
