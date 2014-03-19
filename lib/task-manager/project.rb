
class TM::Project
  attr_reader :name, :id
  attr_reader :tasks

  @@counter = 0

  def self.gen_id
    @@counter += 1
    @@counter
  end

  def initialize(name)
    @name = name
    @id = TM::Project.gen_id

    @tasks = []
  end

  def add_task(desc, priority)
    proj_id = @id

    task = TM::Task.new(proj_id, desc, priority)

    @tasks << task

    task
  end

  def mark_as_complete(task_id)
    task = @tasks.find { |task| task.id == task_id }

    task.completed = true
  end

  def list_completed_tasks
    completed_tasks = @tasks.select { |task| task.completed == true }

    tasks_sorted_by_most_recent = completed_tasks.sort do | x, y |
      y.time_created <=> x.time_created
    end
  end
end
