module TM
  class MarkTaskAsComplete < UseCase
    def run(inputs)
      @database = TM.database
      task = @database.get_task(inputs[:task_id].to_i)
      return failure(:task_not_found) if task.nil?
      return failure(:task_already_completed) if task.status == "complete"

      @database.mark_task_as_complete(task)
      # Return a success with relevant data
      success :task => task
    end
  end
end
