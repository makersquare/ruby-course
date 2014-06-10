
class TM::Task
  attr_reader :id, :description, :priority, :project_id, :created_at

  @@tasks   = [ ]
  @@counter = 0

  def self.tasks
    @@tasks
  end

  def self.tasks_for(project_id, complete = false)
    tasks.select do |task|
      task.complete? == complete && task.project_id == project_id
    end.sort_by do |task|
      if complete
        task.created_at
      else
        [task.priority, task.created_at]
      end
    end
  end

  def initialize description, priority, project_id
    @id          = @@counter += 1
    @description = description
    @priority    = priority
    @project_id  = project_id
    @complete    = false
    @created_at  = Time.now
  end

  def complete?
    @complete
  end

  def complete
    @complete = true
    self
  end
end
