module TM
  class ShowEmployeeProjects < UseCase
    def run(inputs)
      eid = inputs[:eid]
      employee = TM.db.get_employee(eid)
      return failure(:employee_does_not_exist) if employee.nil?
      employee_projects = TM.db.get_employee_projects(eid)
      success(employee_projects: employee_projects, employee: employee)
    end
  end
end
