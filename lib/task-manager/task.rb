
class TM::Task

  attr_reader :id, :created_at
  attr_accessor :complete

  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @complete = false
    @id = self.class.generate_id
    @created_at = Time.now
    self.class.add_task(self)
  end

  def complete?
    @complete
  end

  def self.add_task(task)
    @@tasks ||= {}
    @@tasks[task.id] = task
  end

  def self.tasks
    @@tasks ||= {}
  end

  def self.mark_complete(task_id)
    @@tasks[task_id].complete = true
  end

  private

  def self.generate_id
    tmp = @@id_counter ||= 0
    @@id_counter +=1
    tmp
  end
end
