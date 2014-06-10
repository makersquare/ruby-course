
class TM::Project
  attr_reader :name
  attr_accessor :project_id, :tasks, :completed_tasks

  def initialize(name)
    @name = name
    @project_id = self.object_id * -1
    @tasks = []
    @completed_tasks = []
  end

  def add_task(description, priority, id = @project_id)
    @tasks << TM::Task.new(description, priority, id)
  end

  def list_complete
    @completed_tasks = @tasks.select { |task| task.complete == true }
    @completed_tasks.sort_by! { |task| task.creation_time }
  end

end
