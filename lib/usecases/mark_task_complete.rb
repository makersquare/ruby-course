module TM
  class MarkTaskComplete < UseCase
    def run(inputs)
      task = TM.db.get_task(inputs[:task_id])
      return failure(:task_does_not_exist) if task.nil?

      task.complete = true

      success :task => task
    end
  end
end
