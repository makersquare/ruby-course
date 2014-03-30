module TM
  class ListEmployees < UseCase
    def run
      employees = TM.db.list_employees
      # return failure(:no_employees_created) if employees.count == 0
      success(employees: employees)
    end
  end
end
