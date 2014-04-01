
class TM::Project
@@id = 0
attr_reader :id, :task_list
attr_accessor :name

  def initialize(name)
    @name = name
    @@id += 1
    @id = @@id
    @task_list = []

  end

  def has_task?(task_id)
     @task_list.each do |task|
       return true if task.id == task_id
     end
     return false
   end



  def add_task(task)
    @task_list << task
  end

  def mark_task_complete(id)
    @task_list.each do |task|
       if task.id  == id
           task.complete = true
       end
    end
  end

  def retrieve_complete_tasks
     complete_tasks = []

     @task_list.each do |task|
        complete_tasks << task if task.complete
     end

     complete_tasks.sort_by { |task| task.creation_date }
  end

  def retrieve_incomplete_tasks
      incomplete_tasks = []

      @task_list.each do |task|
         incomplete_tasks << task if !task.complete
      end

      incomplete_tasks.sort_by { |task| task.priority_num }
  end

end



