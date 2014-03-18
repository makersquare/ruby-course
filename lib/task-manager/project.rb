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
  @tasks.each do |x|
  if x.id == task_id
    x.status = "complete"
  end
  end
end

def completed_tasks
  @tasks.select {|x| x.status == "complete"}.sort_by { |x| x.creation_date }
end

def incomplete_tasks
  @tasks.select {|x| x.status == "incomplete"}.sort_by {|x| [-x.priority_number, x.creation_date]}
end
end
