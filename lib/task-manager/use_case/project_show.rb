
module TM

  class ProjectShow < UseCase
    def run(inputs)
      # inputs = { :pid => "user inputted pid"}
      project = TM.db.get_project(inputs[:pid])

      return failure(:project_does_not_exist) if project == nil

      remaining_tasks = TM.db.remaining_task_proj(inputs[:pid])
      success(:project => project, :remaining_tasks => remaining_tasks)
    end

  end

end


