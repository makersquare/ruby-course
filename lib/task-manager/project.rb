
class TM::Project
  attr_reader :id
  attr_accessor :name

  @@class_id = 1
  @@tasks = []

  def initialize(name=nil)
    @name = name
    @id = @@class_id
    @@class_id +=1
  end

  def create_task(project_id, description, priority_number)
   x = TM::Task.new(project_id, description, priority_number)
   @@tasks<<x
  end

  def mark_complete(project_id)
    for i in 0...@@tasks.length
      if @@tasks[i].project_id == project_id
        if @@tasks[i].status = "incomplete"
            @@tasks[i].status = "complete"
            return @@tasks[i].status
        else
          puts "The task is already complete."
        end
      end
    end
  end
end
