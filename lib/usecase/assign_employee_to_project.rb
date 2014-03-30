module TM
  class AssignEmployeeToProject < UseCase
    def run(inputs)
      pid = inputs[:pid]
      eid = inputs[:eid]

      project = TM.db.get_project(pid)
      employee = TM.db.get_employee(eid)

      membership = TM.db.assign_employee_to_project(pid, eid)

      success project: project, employee: employee

    end
  end
end
