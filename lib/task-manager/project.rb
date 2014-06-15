
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

  def add_task(description, priority, id=@tasks.count)
    @tasks << TM::Task.new(description, priority, id)
  end

  def self.complete_task(proj_id_find, task_id_find)
    @@project_list.each do |proj|
      if proj.project_id == proj_id_find
        proj.tasks.each do |task|
          if task.task_id == task_id_find
            task.complete = true
          end
        end
      end
    end

    # project = TM::Project.list_projects.select { |proj| proj.project_id == proj_id_find }
    # task = project[0].tasks.select { |task| task.task_id == task_id_find }
    # task[0].complete = true
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
