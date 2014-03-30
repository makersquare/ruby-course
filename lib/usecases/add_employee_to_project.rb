module TM
  class AddEmployeeToProject < UseCase
    def run(inputs)
      employee = TM.db.get_employee(inputs[:employee_id])
      project = TM.db.get_project(inputs[:project_id])


      return failure(:project_does_not_exist) if project.nil?
      return failure(:employee_does_not_exist) if employee.nil?

      TM.db.join_employees_projects.push({ :employee_id => employee.employee_id, :project_id => project.project_id })

      success :employee => employee, :project => project
    end
  end
end
