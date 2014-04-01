module TM
  class ListAllEmployees < UseCase

    def run(inputs)

      emp = TM.db.all_emp
      return failure(:no_employees_exist) if emp.length == 0

      all_emps = list_all_emps

      # Return a success with relevant data
      success :all_employees => all_emps
    end

    def list_all_emps
      TM.db.all_emp
    end

  end
end
