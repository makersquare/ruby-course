module TM
  class GetEmployeeProjects < UseCase
    def run(employee_id)
      employee = TM::db.get_employee(employee_id)
      if employee == nil
        return failure :employee_not_found
      else
        employee_projects = TM::db.get_assigned_projects(employee_id)
        return success :employee_projects => employee_projects
      end
    end
  end
end
