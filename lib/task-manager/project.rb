
class TM::Project
  attr_reader :name, :id
  attr_accessor :tasks, :complete_tasks, :incomplete_tasks
  @@project_id = 0
  @@projects = []

  def initialize(name)
    @@projects << self
    @name = name
    @@project_id += 1
    @id = @@project_id
    @time = Time.now
    @tasks = []
    @complete_tasks = []
    @incomplete_tasks = []
  end

  def self.print_projects
    @@projects.each {|project| puts "#{project.id}\t#{project.name}"}
  end

  def self.get_project(id)
    @@projects.select {|project| project.id == id}
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
    @complete_tasks = @tasks.select { |task| task.completed == true }
  end

  def todo
    @incomplete_tasks = []
    @incomplete_tasks = @tasks.select {|task| task.completed == false}
    @incomplete_tasks.sort_by! {|task| [task.priority, task.time]}
  end
end
