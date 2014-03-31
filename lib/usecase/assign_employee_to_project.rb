module TM
  class AssignEmployeeToProject < UseCase
    def run(inputs)
      pid = inputs[:pid]
      eid = inputs[:eid]

      project = TM.db.get_project(pid)
      return failure(:project_does_not_exist) if project.nil?
      employee = TM.db.get_employee(eid)
      return failure(:employee_does_not_exist) if employee.nil?

      membership = TM.db.assign_employee_to_project(pid, eid)

      success project: project, employee: employee

    end
  end
end
