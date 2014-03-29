module TM
  class GetProjectsForEmployee < UseCase
    def run(inputs)
      employee = TM.db.get_employee(inputs[:employee_id])

      return failure(:employee_does_not_exist) if employee.nil?

      projects = TM.db.join_employees_projects.select do |hash|
        hash[:employee_id] == inputs[:employee_id]
      end.map do |hash|
        TM.db.get_project(hash[:project_id])
      end

      return failure(:employee_has_no_projects) if projects.size == 0

      success :projects => projects, :employee => employee
    end
  end
end
