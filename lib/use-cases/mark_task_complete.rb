
module TM
  class MarkComplete < UseCase
    def run(inputs)
      tid = inputs[:tid]
      task = TM.DB.get_task(tid)
      return failure(:task_doesnt_exist) if task.nil?
      completed_tasks = TM.DB.task_complete(tid)

      success :tasks => task
    end
  end
end
