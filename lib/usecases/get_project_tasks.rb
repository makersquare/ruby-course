module TM
  class GetProjectTasks < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])

      return failure(:project_does_not_exist) if project.nil?

      tasks = TM.db.get_project_tasks(project.project_id)

      success :tasks => tasks
    end
  end
end
