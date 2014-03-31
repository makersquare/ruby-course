module TM
  class ShowCompletedEmployeeTasks < UseCase
    def run(inputs)
      eid = inputs[:eid]
      employee = TM.db.get_employee(eid)
      return failure(:employee_does_not_exist) if employee.nil?

      completed_tasks = TM.db.show_completed_employee_tasks(eid)

      associated_projects = completed_tasks.map {|task| TM.db.get_project(task.pid)}

      success(completed_tasks: completed_tasks, associated_projects: associated_projects)

    end
  end
end
