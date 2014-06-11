
class TM::Project

  @@id_generator = 0
  @@project_list = []

  attr_reader :name
  attr_accessor :project_id, :id_generator, :tasks, :completed_tasks, :incompleted_tasks, :project_list

  def initialize(name)
    @name = name
    @project_id = @@id_generator
    @@id_generator += 1
    @@project_list << self
    @tasks = []
    @completed_tasks = []
    @incompleted_tasks = []
  end

  def self.list_projects
    @@project_list
  end

  def id_generator
    @@id_generator
  end

  def add_task(description, priority, id = @project_id)
    @tasks << TM::Task.new(description, priority, id)
  end

  def list_complete
    @completed_tasks = @tasks.select { |task| task.complete == true }
    @completed_tasks.sort_by! { |task| task.creation_time }
  end

  def list_incomplete
    @incompleted_tasks = @tasks.select { |task| task.complete == false }
    @incompleted_tasks.sort_by! { |task| task.priority && task.creation_time }
  end

end
