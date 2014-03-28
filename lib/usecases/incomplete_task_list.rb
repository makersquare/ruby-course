module TM
  class IncompleteTaskList < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])
      return failure(:project_does_not_exist) if project.nil?

      tasks = TM.db.incomplete_task_list(inputs[:project_id])
      success :tasks => tasks
    end
  end
end
