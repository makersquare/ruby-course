
class TM::Project
@@id = 0
attr_reader :name, :id, :task_list

def initialize(name)
  @name = name
  @@id += 1
  @id = @@id
  @task_list = []
end

def add_task(project_id,description,priority,task_id)
  @task_list << TM::Task.new(project_id,description,priority,task_id)
end

end
