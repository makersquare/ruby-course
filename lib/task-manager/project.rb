
class TM::Project

  @@counter = 0

  attr_reader :project_name, :id
  attr_accessor :tasks

  def self.generate_id
    @@counter +=1
    @@counter
  end

  def initialize(project_name)
    @project_name = project_name
    @id = TM::Project.generate_id
    @tasks = []

  end

  def add_task(task)
    task.project_id = @id
    @tasks.push(task)
  end

  def mark_task_complete(task_id)
    completed_task = @tasks.find{|task| task.id == task_id}
    completed_task.complete = true
  end


end
