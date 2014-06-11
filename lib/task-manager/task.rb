
class TM::Task
  attr_reader :id, :description, :priority, :project_id, :created_at

  @@tasks   = [ ]
  @@counter = 0

  def self.all
    @@tasks
  end

  def self.find(task_id)
    @@tasks.find {|t| t.id == task_id}
  end

  def self.tasks_for(project_id, complete = false)
    all.select do |task|
      task.complete? == complete && task.project_id == project_id
    end.sort_by do |task|
      if complete
        task.created_at
      else
        [task.priority, task.created_at]
      end
    end
  end

  def self.set_complete(task_id)
    task = find(task_id)
    task.complete
  end

  def initialize project_id, priority, description
    @id          = @@counter += 1
    @description = description
    @priority    = priority
    @project_id  = project_id
    @complete    = false
    @created_at  = Time.now

    @@tasks << self
  end

  def complete?
    @complete
  end

  def complete
    @complete = true
    self
  end
end
