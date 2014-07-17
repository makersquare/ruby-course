module TM
  class CompleteTaskList < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])

      return failure(:project_does_not_exist) if project.nil?
      tasks = TM::GetProjectTasks.run({ :project_id => project.project_id}).tasks
      tasks.select! { |task| task.complete }
      tasks.sort_by! { |task| task.timecreated }

      return failure(:project_has_no_complete_tasks) if tasks.size == 0

      success :tasks => tasks, :project => project
    end
  end
end
