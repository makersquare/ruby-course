module TM
  class ShowCompletedTasks < UseCase
    def run(inputs)
      pid = inputs[:pid]
      retrieved_project = TM.db.get_project(pid)
      completed_tasks = TM.db.show_completed_tasks(pid)

      return failure(:project_doesnt_exist) if retrieved_project.nil?
      success completed_tasks: completed_tasks

    end
  end
end
