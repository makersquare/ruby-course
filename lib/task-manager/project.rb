
module TM
class Project

  attr_reader :name, :all_tasks

  @@id = 0

  def initialize(name)
    @name = name
    @@id +=1
    @all_tasks = {}
    @comp_tasks = {}
    @inc_tasks = {}
  end

  def add_task(description, priority) # adds task to relevant lists; returns total number of tasks in project
    new_task = Task.new(@@id, description, priority)
    @all_tasks[new_task.id] = new_task
    @inc_tasks[new_task.id] = new_task
    @all_tasks.keys.length
  end

  def mark_complete(task_id) # marks tasks as complete, returns marked task
    @all_tasks[task_id].mark_comp
    @comp_tasks[task_id] = @all_tasks[task_id]
    @inc_tasks.delete(task_id)
    @all_tasks[task_id]
  end


  def mark_incomplete(task_id) # marks tasks as incomplete, returns marked task
    @all_tasks[task_id].mark_inc
    @inc_tasks[task_id] = @all_tasks[task_id]
    @comp_tasks.delete(task_id)
    @all_tasks[task_id]
  end

  def sort_comp # return array of completed tasks sorted by create date
    @comp_tasks.to_a.sort{|task1, task2| task1[1].created <=> task2[1].created}
  end

  def sort_inc # return array of incomplete tasks sorted by priority then create date
     @inc_tasks.to_a.sort{|task1, task2|
        if task1[1].priority == task2[1].priority
          task1[1].created <=> task2[1].created
        else
          task1[1].priority <=> task2[1].priority
        end
        }
  end

  def id
    @@id
  end

end
end

# Client should be able to add/create new project
# Project manager should be renamed to Terminal Client

# used "module TM" above because keyword module re-opens the module, whereas
# "TM::some_class" (the scope operator) just indicates that the specified
# class is within the module

# note that user will have to supply task ID in order to delete task
# from the project. ergo task IDs should be memorable, i.e. not just
# numbers
