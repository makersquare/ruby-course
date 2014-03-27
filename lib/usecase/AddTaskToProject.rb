module TM
  class AddTaskToProject < UseCase
    def run(inputs)
      @database = TM.database
      project = @database.get_project(inputs[:project_id].to_i)
      return failure(:project_not_found) if project.nil?

      task = @database.add_task(project.id, inputs[:priority], inputs[:description])
      # Return a success with relevant data
      success :project => project, :task => task
    end
  end
end
