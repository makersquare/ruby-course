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

  def add_task(task)
    @tasks << task
  end

  def completed
    t = @tasks.select {|task| task.complete}
    t.sort_by {|t| t.timestamp}.reverse
  end

  def incomplete
    t = @tasks.select {|task| task.complete == false}
    t.sort_by {|task| [task.priority, task.timestamp]}
  end

end
