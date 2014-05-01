class TM::Project

  attr_reader :name, :id
  attr_accessor :tasks

  @@id_counter = 0
  @@projects = []

  def initialize(name)
    @name = name
    @@id_counter += 1
    @id = @@id_counter
    @tasks = []
    @@projects << self
  end

  def to_s
    "#{@id} | #{@name}"
  end

  def self.projects
    @@projects
  end

  def self.projects=(arg)
    @@projects = arg
  end

  def self.find_project_by_id(pid)
    @@projects.select {|p| p.id == pid.to_i}
  end

  def add_task(task)
    @tasks << task
  end

  def completed
    t = @tasks.select {|task| task.complete}
    t.sort_by {|t| t.timestamp}.reverse
  end

  def incomplete
    t = @tasks.select {|task| !task.complete? }
    t.sort_by {|task| [task.priority, task.timestamp]}
  end

  def self.reset_class_vars
    @@id_counter = 0
    @@projects = []
  end

end
