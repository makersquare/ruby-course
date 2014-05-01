class TM::Project

attr_accessor :name, :id, :tasks
@@project_id_counter = 1
def initialize(name)
  @name = name
  @id = @@project_id_counter
  @@project_id_counter += 1
  @tasks = []
end

def self.project_id_counter=(value)
    @@project_id_counter=value
  end

def self.reset_Class_variable
    @@project_id_counter = 1
  end

def create_new_task(description, priority_number)
  task = TM::Task.new(@id, description, priority_number)
  @tasks << task
  task
end

def complete_task(task_id)
  @tasks.each do |task|
  if task.id == task_id
    task.status = "complete"
  end
  end
end

def completed_tasks
  @tasks.select {|task| task.status == "complete"}.sort_by { |task| task.creation_date }
end

def incomplete_tasks
  @tasks.select {|task| task.status == "incomplete"}.sort_by {|task| [-task.priority_number, task.creation_date]}
end
end
