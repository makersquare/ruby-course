module TM
  class MarkTaskComplete < UseCase
    def run(inputs)
      tid = inputs[:tid]
      completed_task = TM.db.mark_task_complete(tid)

      success(completed_task: completed_task)

    end
  end
end
