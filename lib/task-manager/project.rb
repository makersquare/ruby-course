
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
    task.time_completed = Time.now
  end

  def list_completed_tasks
    completed_tasks = @tasks.select { |task| task.completed == true }

    # x and y represent the the objects in the array.
    #
    # If y comes first in y <=> x, it means we want to sort by highest number of a value, going to lowest number of a value
    #
    # thus y.time_created <=> x.time_created means sort by most recent time to least recent time
    tasks_sorted_by_most_recent = completed_tasks.sort do |x,y|
      y.time_created <=> x.time_created
    end
  end

  def list_incomplete_tasks
    incomplete_tasks = @tasks.select { |task| task.completed == false }

    # x and y represent the the objects in the array.
    #
    # If y comes first in y <=> x, it means we want to sort by highest number of a value, going to lowest number of a value
    #
    # thus y.priority <=> x.priority means sort by highest numbered priority to lowest numbered priority
    # task_by_highest_priority = incomplete_tasks.sort do |x,y|
    #   y.priority <=> x.priority
    # end

    incomplete_tasks.sort_by { |x| [-x.priority, x.time_created.to_f] }

  end

  def include_task?(tid)
    task = @tasks.find { |tsk| tsk.id == tid }

    @tasks.include?(task)
  end
end
