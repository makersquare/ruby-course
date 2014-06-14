
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

  def sort_creation_date
    @tasks.sort {|x,y| y.creation_date <=> x.creation_date}
  end

  def project_mark_complete(id)
    @tasks.map do |x|
      if x.task_id == id && x.status == "incomplete"
        x.status = "complete"
        x
      end
    end
  end

  def retrieve_completed_tasks
    sorted = @tasks.map do |x|
      if x.status == "complete"
        x
      end
    end
    sorted.compact.sort do |x,y| #returns nil value run compact on sorted
      x.creation_date <=> y.creation_date
    end
  end

  def mark_incomplete(id)
    sorted = @tasks.map do |x|
      if x.task_id == id
        x.mark_incomplete
      end
    end
  end

  def retrieve_incomplete_tasks
    #sorted by priority
    #if priorities are equal
    #sort by creation date (oldest first)
    sorted_tasks = @tasks.map {|x| x.status == "incomplete"}
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
end

