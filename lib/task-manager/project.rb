class TM::Project

attr_accessor :name, :id, :tasks

def initialize(name)
  @name = name
  @id = self.class.project_id_counter
  @tasks = []
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
  task.status = true
  end
  end
end

def completed_tasks
  @tasks.select {|task| task.status == true }.sort_by! do
  |task| task.created_at
 end
end

def incomplete_tasks
  @tasks.each {|task| task.status == false }.sort_by! do |task|
  [1-task.priority_no, task.created_at]
end
end

private
def self.project_id_counter
  temp = @@project_id_counter ||= 0
  @@project_id_counter += 1
  temp
end

def self.project_id_counter=(count)
  @@project_id_counter=count
end
end
