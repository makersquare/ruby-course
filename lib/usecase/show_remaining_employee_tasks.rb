module TM
  class ShowRemainingEmployeeTasks < UseCase
    def run(inputs)
      eid = inputs[:eid]

      remaining_tasks = TM.db.show_remaining_employee_tasks(eid)

      associated_projects = remaining_tasks.map {|task| TM.db.get_project(task.pid)}

      success(remaining_tasks: remaining_tasks, associated_projects: associated_projects)

    end
  end
end
