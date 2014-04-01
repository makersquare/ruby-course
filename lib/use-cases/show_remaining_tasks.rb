module TM
  class ShowRemainingTasks < UseCase
    def run(inputs)
      proj_id = inputs[:pid]
      remaining_tasks = TM.DB.show_remaining_tasks(proj_id)
      project = TM.DB.get_project(proj_id)

      return failure(:provide_a_project_id) if proj_id.nil?
      return failure(:project_doesnt_exist) if project.nil?

      success :tasks => remaining_tasks
    end
  end
end

