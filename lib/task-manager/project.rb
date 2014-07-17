
class TM::Project

  attr_reader :name, :id
  attr_accessor :tasks

  @@id_count = 0
  @@projects = []

  def initialize(name)

    @name = name
    @@id_count += 1
    @id = @@id_count
    @tasks = []
    @@projects << self

  end

  def add_task(task)
    @tasks << task
  end

  def self.projects
    @@projects
  end

  def self.projects=(var)
    @@projects = var
  end

  def self.find_pid(pid)
    @@projects.select {|p| p.id == pid}.first
  end

  def self.reset_class_variables
    @@id_count = 0
    @@projects =[]
  end

  def completed_task_list
    t = @tasks.select {|task| task.complete}
    t.sort_by {|task| task.creation_date}.reverse
  end

  def incompleted_task_list
    t = @tasks.select {|task| !task.complete?}
    t.sort_by {|task| [task.creation_date, task.priority_number]}
  end

  def view
    "#{@id}: #{@name}"
  end

end
