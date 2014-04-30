
class TM::Project
  attr_reader :name, :id
  attr_accessor :tasks, :complete_tasks
  @@project_id = 0

  def initialize(name)
    @name = name
    @@project_id += 1
    @id = @@project_id
    @time = Time.now
    @tasks = []
    @complete_tasks = []
    @incomplete_tasks = []
  end

  def new_task(description, priority)
    @tasks << TM::Task.new(@id, description, priority)
  end

  def self.reset_class_variables
    @@project_id = 0
  end

  def set_priority(task_id, new_priority)
    for x in @tasks
      if x.tid == task_id
        x.priority = new_priority
      end
    end
  end

  def completed_tasks
    @complete_tasks = []
    @tasks.each { |task| @complete_tasks << task if task.completed == true }
    @completed_tasks
  end
end
