
class TM::Project

  @@class_id = 0

  attr_reader :name
  attr_accessor :id, :tasks

  def initialize(name)
    @name = name
    @id = @@class_id +=1
    @tasks = []
  end

  def create_task(name, priority_number, description = nil)
    task = TM::Task.new(name, priority_number, description, @id)
    @tasks << task
  end

  def retrieve_completed_tasks

  end

  def retrieve_incomplete_tasks
  end

  def sort_creation_date

  end

  def sort_priority
  end
end
