module TM
  class DelegateEmployeeToProject < UseCase
    def run(inputs)
      @database = TM.database
      employee = @database.get_employee()
      return failure(:employee_not_given_name) if inputs[:name] == ''
      employee = @database.add_new_employee(inputs[:name])
      # Return a success with relevant data
      success :employee => employee
    end
  end
end
