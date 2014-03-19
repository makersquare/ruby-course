
module TM
class Project
  # remove reader attr for all_tasks, inc_tasks, comp_tasks
  attr_reader :name, :all_tasks

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

  def mark_complete(task_id)
    @all_tasks[task_id].mark_comp
    @comp_tasks[task_id] = @all_tasks[task_id]
    @inc_tasks.delete(task_id)
    @all_tasks[task_id]
  end

  def mark_incomplete(task_id)
    @all_tasks[task_id].mark_inc
    @inc_tasks[task_id] = @all_tasks[task_id]
    @comp_tasks.delete(task_id)
    @all_tasks[task_id]
  end

  def sort_comp
    @comp_tasks.to_a.sort{|task1, task2| task1[1].created <=> task2[1].created}
    # return sorted array of completed tasks
  end

  def sort_inc
     @inc_tasks.to_a.sort{|task1, task2|
        if task1[1].priority == task2[1].priority
          task1[1].created <=> task2[1].created
        else
          task1[1].priority <=> task2[1].priority
        end
        }
  end

  def ls_comp
    @comp_tasks.to_a
  end

  def ls_inc
    @inc_tasks.to_a
  end

  def id
    @@id
  end

end
end

# Client should be able to add/create new project
# Project manager should be renamed to Terminal Client

# used "module TM" above because keyword module re-opens the module, whereas
# "TM::some_class" (the scope operator) just points to the module

# note that user will have to supply task ID in order to delete task
# from the project. ergo task IDs should be memorable, i.e. not just
# numbers
