class TM::Project

  @@class_id = 0
  @@project_list = {}

  attr_reader :name
  attr_accessor :id, :tasks

  def initialize(name)
    @name = name
    @id = @@class_id +=1
    @tasks = []
    @@project_list[@id] = self
  end

  def create_task(name, priority_number, description = nil)
    task = TM::Task.new(name, priority_number, description, @id)
    @tasks << task
    task
  end

  # def sort_creation_date
  #   @tasks.sort {|x,y| y.creation_date <=> x.creation_date}
  # end

  def project_mark_complete(id)
    @tasks.map do |x|
      if x.task_id == id && x.status == "incomplete"
        # x.status = "complete"
        x.mark_complete
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

  def retrieve_incomplete_tasks
    #sorted by priority
    #if priorities are equal
    #sort by creation date (oldest first)
    sorted = @tasks.map do |x|
      if x.status == "incomplete"
        x
      end
    end
    sorted.compact.sort do |x, y|
      if x.priority_number != y.priority_number
        x.priority_number <=> y.priority_number
      else
        x.creation_date <=> y.creation_date
      end
    end
  end

  def self.project_list
    @@project_list
  end
end

