module TM
  class GetProjectEmployees < UseCase
    def run(inputs)
      project_employees = []
      pid = inputs[:pid]
      project = TM.db.get_project(pid)
      return failure(:project_does_not_exist) if project.nil?
      project_employee_ids = TM.db.get_project_membership(pid)
      return failure(:no_employees_assigned_to_this_project) if project_employee_ids == []
      project_employee_ids.map do |eid|
        project_employees.push(TM.db.get_employee(eid))
      end

      success project_employees: project_employees

    end
  end
end
