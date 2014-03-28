module TM
  class GetEmployeesOnProject < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])

      return failure(:project_does_not_exist) if project.nil?

      employees = TM.db.get_employees_on_project(project.project_id)

      return failure(:no_employees_on_project) if employees.size == 0

      success :employees => employees
    end
  end
end
