module TM
  class DelegateEmployeeToProject < UseCase
    def run(inputs)
      @database = TM.database
      return failure(:employee_not_number) if inputs[:employee_id].to_i == 0
      return failure(:project_not_number) if inputs[:project_id].to_i == 0
      employee = @database.get_employee(inputs[:employee_id].to_i)
      return failure(:employee_not_found) if employee.nil?

      project = @database.get_project(inputs[:project_id].to_i)
      return failure(:project_not_found) if project.nil?

      @database.delegate_employee_to_project(inputs[:employee_id].to_i, inputs[:project_id].to_i)
      # Return a success with relevant data
      success :employee => employee, :project => project
    end
  end
end
