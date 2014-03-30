module TM
  class AddTaskToProject < UseCase
    def run(inputs)
      @database = TM.database
      return failure(:no_project_id_given) if inputs[:project_id] == nil
      return failure(:project_id_not_number) if inputs[:project_id].to_i == 0
      project = @database.get_project(inputs[:project_id].to_i)
      return failure(:project_not_found) if project.nil?
      return failure(:no_priority_given) if inputs[:priority] == nil
      return failure(:priority_not_number) if inputs[:priority].to_i == 0
      return failure(:no_description_given) if inputs[:description] == []

      task = @database.add_task(project.id, inputs[:priority].to_i, inputs[:description].join(' '))
      # Return a success with relevant data
      success :project => project, :task => task
    end
  end
end
