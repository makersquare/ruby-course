
class TM::Task

  attr_reader :id, :created_at, :priority_number, :description, :project_id
  attr_accessor :complete, :completed_at

  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @complete = false
    @id = self.class.generate_id
    @created_at = Time.now
    @completed_at = nil
    self.class.add_task(self)
  end

  def complete?
    @complete
  end

  def self.add_task(task)
    # @@tasks ||= {}
    # @@tasks[task.id] = task

    @@tasks ||= []
    @@tasks << task
  end

  def self.tasks
    # @@tasks ||= {}

    @@tasks ||= []
  end

  def self.mark_complete(task_id)
    # task = @@tasks[task_id]

    task = @@tasks.select { |task| task.id == task_id }
    task = task[0]
    task.completed_at = Time.now
    task.complete = true
  end

  private

  def self.generate_id
    tmp = @@id_counter ||= 0
    @@id_counter +=1
    tmp
  end
end
