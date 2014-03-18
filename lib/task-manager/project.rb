
module TM
class Project
  # remove reader attr for all_tasks, inc_tasks, comp_tasks
  attr_reader :name

  @@id = 0

  def initialize(name)
    @name = name
    #either declare ID as class var or make random
    @@id +=1
    @all_tasks = {}
    @comp_tasks = {}
    @inc_tasks = {}
  end

# Interface: ask user for task description and priority
  def add_task(description, priority)
    new_task = Task.new(@@id, description, priority)
    @all_tasks[new_task.id] = new_task
    @inc_tasks[new_task.id] = new_task
    @all_tasks.keys.length
  end


end
end


# used "module TM" above because keyword module re-opens the module, whereas
# "TM::some_class" (the scope operator) just points to the module
