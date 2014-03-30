module TM
  class RemainingOfProject < UseCase
    def run(inputs)
      @database = TM.database
      project = @database.get_project(inputs[:project_id].to_i)
      return failure(:project_not_found) if project.nil?

      tasks = @database.get_project_remaining(project.id)
      return failure(:no_remaining_tasks_found) if tasks == []
      # Return a success with relevant data
      success :project => project, :tasks => tasks
    end
  end
end
