
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

  def add_task(task)
    @tasks << task
  end

  def get_tasks_by_status(status)
    t = tasks.select {|task| task.status == status}
    # t.sort_by {|t| t.timestamp }
    # sorting should take place in terminal?
  end

  # def tasks(status)
  #   a, b = tasks.partition {|task| task.status == status}
  #   return a
  # end
end
