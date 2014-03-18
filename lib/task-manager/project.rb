
class TM::Project
attr_accessor :name, :id, :tasks
@@id_counter = 1
def initialize(name)
  @name = name
  @id = @@id_counter
  @@id_counter += 1
  @tasks = []
end

def self.id_counter=(value)
    @@id_counter=value
  end

def create_new_task(description, priority_number)
  blue = TM::Task.new(@id, description, priority_number)
  @tasks.push(blue)
  blue
end

def complete_task(task_id)

end
end
