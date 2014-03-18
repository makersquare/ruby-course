
class TM::Project
  attr_reader :name, :id, :tasks

  @@current_id = 1


  def self.current_id=(current_id)
    @@current_id = current_id
  end


  def initialize(name)
    @name = name
    @id = @@current_id
    @@current_id = @@current_id + 1
    @tasks = []
  end

  def add_task(task)

    # if it's a task, just add it
    if task.is_a?(TM::Task)
      @tasks << task
      return true
    end

    # if it's a number, add it using the id


  end



end
