module TM
  class CompleteTaskList < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])
      return failure(:project_does_not_exist) if project.nil?

      tasks = TM.db.complete_task_list(inputs[:project_id])
      success :tasks => tasks
    end
  end
end
