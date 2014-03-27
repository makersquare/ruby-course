module TM
  class AssignTaskToProject < UseCase
    def run(inputs)

      # Check for task name
      if inputs[:name].nil?
        return failure(:missing_task_name)
      end

      project = TM.db.get_project(inputs[:project_id])
      return failure(:missing_project) if project.nil?

      inputs[:priority] ||= 10
      add_task_to_proj(inputs[:project_id], inputs[:name], inputs[:priority])
    end
  end
end
