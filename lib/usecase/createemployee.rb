module TM
  class CreateEmployee < UseCase
    def run(inputs)
      @database = TM.database
      return failure(:employee_not_given_name) if inputs[:name] == ''
      employee = @database.add_new_employee(inputs[:name])
      # Return a success with relevant data
      success :employee => employee
    end
  end
end
