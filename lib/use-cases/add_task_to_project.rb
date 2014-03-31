module TM
  class AddTaskToProject < UseCase
    def run(inputs)
      proj_id = inputs[:pid]
      description = inputs[:description]
      priority = inputs[:priority]
      added_tasks = TM.DB.add_task_to_project(description, priority, proj_id)
      project = TM.DB.get_project(proj_id)
      return failure(:provide_a_project_id) if proj_id.nil?
      return failure(:provide_a_task_description) if description.nil?
      return failure(:project_doesnt_exist) if project.nil?

      success :tasks => added_tasks
    end
  end
end

