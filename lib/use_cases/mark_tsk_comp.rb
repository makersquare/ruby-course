module TM
  class MarkTaskAsComplete < UseCase

    def run(inputs)
      task = TM.db.get_task(inputs[:task_id].to_i)
      return failure(:task_does_not_exist) if task.nil?

      updated_task = mark_task_complete(task)
      # Return a success with relevant data
      success :task => updated_task
    end

    def mark_task_complete(task)
      TM.db.update_task(task.id, {complete: true})
    end

  end
end
