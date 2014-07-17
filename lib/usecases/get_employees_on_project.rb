module TM
  class GetEmployeesOnProject < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])

      return failure(:project_does_not_exist) if project.nil?

      join_array = TM.db.join_employees_projects

      employees = join_array.select do |hash|
        hash[:project_id] == project.project_id
      end.map do |hash|
        TM.db.get_employee(hash[:employee_id])
      end

      return failure(:no_employees_on_project) if employees.size == 0

      success :employees => employees
    end
  end
end
