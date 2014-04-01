module TM
  class MarkTask < UseCase
    def run(task_id)
      task = TM::db.get_task(task_id)
      if task == nil
        return failure(:task_not_found)
      else
        if task.finished? == true
          return failure(:task_already_completed)
        else
          task.finished = true
          return success(:task => task)
        end
      end
    end
  end
end
