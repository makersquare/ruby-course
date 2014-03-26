
module TM
class Project

  attr_reader :name, :all_tasks

  @@num_projects = 0

  def initialize(name)
    @name = name
    @@num_projects +=1
    @id = @@num_projects
    @all_tasks = {}
    @comp_tasks = {}
    @inc_tasks = {}
  end

  def add_task(description, priority) # adds task to relevant lists; returns total number of tasks in project
    new_task = Task.new(@id, description, priority)
    @all_tasks[new_task.id] = new_task
    @inc_tasks[new_task.id] = new_task
    new_task
  end

  def mark_complete(task_id) # marks tasks as complete, returns marked task
    if @all_tasks[task_id] != nil
      @all_tasks[task_id].mark_comp
      @comp_tasks[task_id] = @all_tasks[task_id]
      @inc_tasks.delete(task_id)
      @all_tasks[task_id]
    else
      "No such task exists in this project."
    end
  end


  def mark_incomplete(task_id) # marks tasks as incomplete, returns marked task
    if @all_tasks[task_id] != nil
      @all_tasks[task_id].mark_inc
      @inc_tasks[task_id] = @all_tasks[task_id]
      @comp_tasks.delete(task_id)
      @all_tasks[task_id]
    else
      "No such task exists in this project."
    end
  end

  def sort_comp # return array of completed tasks sorted by create date
    if @comp_tasks.length != 0
      @comp_tasks.to_a.sort{|task1, task2| task1[1].created <=> task2[1].created}
    else
      "There are no completed tasks in this project."
    end
  end

  def sort_inc # return array of incomplete tasks sorted by priority then create date

     if @inc_tasks.length != 0
        @inc_tasks.to_a.sort{|task1, task2|
        if task1[1].priority == task2[1].priority
          task1[1].created <=> task2[1].created
        else
          task1[1].priority <=> task2[1].priority
        end
        }
      else
        "There are no incomplete tasks in this project."
      end
  end

  # inc_tasks is {task_id => task, task_id => task}
  # inc_tasks.to_a is [[task_id, task], [task_id, task]]
  # sort inc returns the above array sorted


  def hi_prio
    incom_arr = self.sort_inc
    counter = 0

      if incom_arr.length != 0
        incom_arr.each do |task_arr|
          if task_arr[1].priority >= 4
            counter +=1
          end
        end
      end

    return counter
  end

  def id
    @id
  end

end
end

# Client should be able to add/create new project
# Project manager should be renamed to Terminal Client

# used "module TM" above because keyword module re-opens the module, whereas
# "TM::some_class" (the scope operator) just indicates that the specified
# class is within the module
