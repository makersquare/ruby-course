class TM::Project

@@project_id_counter = 1
attr_accessor :name, :id, :tasks

def initialize(name)
  @name = name
  @id = @@project_id_counter
  @@project_id_counter += 1
  @tasks = []
end

def self.project_id_counter=(count)
  @@project_id_counter=count
end

def self.reset_Class_variable
  @@project_id_counter = 1
end

def create_new_task(description, priority_no)
  task = TM::Task.new(@id, description, priority_no)
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
  @tasks.each {|task| task.status == "complete" }.sort_by! do
  |task| task.creation_date
 end
end

def incomplete_tasks
  @tasks.each {|task| task.status == "incomplete" }.sort_by! do |task|
  [1 - task.priority_no, task.creation_date]
end
end
end
