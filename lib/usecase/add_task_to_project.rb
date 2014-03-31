module TM
  class AddTaskToProject < UseCase
    def run(inputs)
      description = inputs[:description]
      priority = inputs[:priority]
      pid = inputs[:pid]
      project = TM.db.get_project(pid)
      return failure(:project_does_not_exist) if project.nil?
      added_task = TM.db.add_task_to_project(description, priority, pid)

      success(added_task: added_task, project: project)

    end
  end
end
