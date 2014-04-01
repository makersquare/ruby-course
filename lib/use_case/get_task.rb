module TM
  class GetTask < UseCase
    def run(task_id)
      task = TM::db.get_task(task_id)
      if task == nil
        return failure(:task_not_found)
      end

      return success(:task => task)
    end
  end
end
