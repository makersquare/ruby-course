module TM
  class ShowEmployeeProjects < UseCase
    def run(inputs)
      eid = inputs[:eid]
      employee_projects = TM.db.get_employee_projects(eid)
      success(employee_projects: employee_projects)
    end
  end
end
