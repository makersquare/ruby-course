module TM
  class GetAllEmployees < UseCase
    def run(inputs)
      employees = TM.db.get_all_employees

      return failure(:no_employees_exist) if employees == []

      success :employees => employees
    end
  end
end
