module TM
  class ShowRemainingTasks < UseCase
    def run(inputs)
      pid = inputs[:pid]
      return failure(:enter_a_project_id) if pid.nil?
      retrieved_project = TM.db.get_project(pid)
      remaining_tasks = TM.db.show_remaining_tasks(pid)

      return failure(:project_doesnt_exist) if retrieved_project.nil?

      success remaining_tasks: remaining_tasks
    end
  end
end
