
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

  def self.tasks_for(project_id, completed = false)
    all.select do |task|
      task.complete? == completed && task.project_id == project_id
    end.sort_by do |task|
      if completed
        task.created_at
      else
        [task.priority, task.created_at]
      end
    end
  end

  def self.set_complete(task_id)
    task = find(task_id)
    task.mark_complete
  end

  def initialize project_id, priority, description
    @id          = @@counter += 1
    @description = description
    @priority    = priority
    @project_id  = project_id
    @completed   = false
    @created_at  = Time.now

    @@tasks << self
  end

  def create
    args = TM.db.create_task( [ @priority, @description, @project_id, @employee_id, @completed ] )
    @id         = args[:id]
    @created_at = args[:created_at]
    self
  end

  def complete?
    @completed
  end

  def mark_complete
    @completed = true
    self
  end
end
