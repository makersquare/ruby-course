
class TM::Project

  @@id_hello = 0

  attr_reader :name
  attr_accessor :id, :tasks

  def initialize(name)
    @name = name
    @id = @@id_hello +=1
    # @tasks = {}
    @tasks = [{}, {}]
  end

  def create_task(name, priority_number, description = nil)
    task = TM::Task.new(name, priority_number, description)
    @tasks[0][task] = @id
  end

  def sort_tasks_priority

  end

  def sort_tasks_date
  end

  def complete_tasks
    #how to search for tasks within the hash
    @tasks[1]

  end

  def incomplete_tasks
  end
end
