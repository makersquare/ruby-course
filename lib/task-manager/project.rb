
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
    sorted_tasks = @tasks.map {|x| x.status = "complete"}

    sorted_tasks.sort {|x,y| x.creation_date <=> y.creation_date} #return a list of sorted tasks by creation date
    # sorted_tasks.sort {|x| x.creation_date}
  end

  def retrieve_incomplete_tasks
    #sorted by priority
    #if priorities are equal
    #sort by creation date (oldest first)
    sorted_tasks = @tasks.map {|x| x.status = "incomplete"}
    sorted_tasks.sort {|x, y|
    if x.priority_number > y.priority_number
      return 1
    elsif x.priority_number < y.priority_number
      return -1
    else
      x.creation_date <=> y.creation_date
    end
    }
  end

  def mark_complete(id)
    sorted = @tasks.map {|x|
      x.task_id == id
      x
    }
    sorted.each do |task|
      task.mark_complete
    end
  end

  def mark_incomplete(id)
    sorted = @tasks.map {|x|
      x.task_id == id
      x
    }
    sorted.each do |task|
      task.mark_incomplete
    end
  end
end
