module TM
  class GetProjectTasks < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])
      return failure(:project_does_not_exist) if project.nil?

      tasks = TM.db.get_all_tasks.select { |task| task.project_id == project.project_id }

      success :tasks => tasks, :project => project
    end
  end
end
