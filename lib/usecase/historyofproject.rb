module TM
  class HistoryOfProject < UseCase
    def run(inputs)
      @database = TM.database
      project = @database.get_project(inputs[:project_id].to_i)
      return failure(:project_not_found) if project.nil?

      tasks = @database.get_project_history(project.id)
      return failure(:no_completed_tasks_found) if tasks == []
      # Return a success with relevant data
      success :project => project, :tasks => tasks
    end
  end
end
