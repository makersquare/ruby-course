
class TM::Project
@@id = 0
attr_reader :name, :id, :task_list

class TM::Project
  @@id = 0
  def initialize(name)
    @name = name
    @@id += 1
    @id = @@id
    @task_list = []
  end

  def add_task(task)
    @task_list << task
  end

  def mark_task_complete(id)
    @task_list.each do |task|
       if task.task_id  == id
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

      incomplete_tasks.sort_by { |task| task.creation_date }
  end

end
end
