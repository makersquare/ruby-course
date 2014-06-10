
class TM::Project
  attr_reader :name, :id, :incompleted_tasks, :completed_tasks

  @@counter = 0

  def initialize name
    @name = name
    @id   = @@counter += 1
    @incompleted_tasks = [ ]
    @completed_tasks   = [ ]
  end

  def new_task(description, priority)
    task = TM::Task.new(description, priority, id)
    incompleted_tasks << task
    task
  end
end
