module TM
  class GetEmployee < UseCase
    def run(employee_id)
      employee = TM::db.get_employee(employee_id)
      if employee == nil
        return failure(:employee_not_found)
      end

      return success(:employee => employee)
    end
  end
end
