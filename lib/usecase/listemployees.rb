module TM
  class ListEmployees < UseCase
    def run(inputs)
      @database = TM.database
      employees = @database.get_all_employees
      return failure(:no_employees_found) if employees == {}

      # Return a success with relevant data
      success :employees => employees
    end
  end
end
