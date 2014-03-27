module TM
  class AddEmployeeToProject < UseCase
    def run(inputs)
      employee = TM.db.get_employee(inputs[:employee_id])
      project = TM.db.get_project(inputs[:project_id])

    end
  end
end
