module TM
  class ProjectHistory < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:pid])

      return failure(:project_does_not_exist) if project == nil
      completed_tasks = TM.db.completed_task_proj(inputs[:pid])

      success(:project => project, :completed_task => completed_tasks)
    end
  end

end
