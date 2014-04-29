
class TM::Project

  attr_reader :name, :id, :tasks

  @@id_counter = 0

  def initialize(name)
    @name = name
    @@id_counter += 1
    @id = @@id_counter
    @tasks = []
  end

  def add_task(task)
    @tasks << task
  end
end
