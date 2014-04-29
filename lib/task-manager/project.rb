
class TM::Project
  @@counter = 1
  attr_accessor :name
  attr_reader :id, :tasks
  def initialize(name)
    @name = name
    @id = @@counter
    @@counter += 1
    @tasks = []
  end

  def add_task(task)
    @tasks << task
  end

  def mark_complete(task_id)
    @tasks.each do |task|
      if task.task_id == task_id
        task.status = "Completed"
      end
    end
  end
end
