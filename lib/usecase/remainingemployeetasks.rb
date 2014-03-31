module TM
  class RemainingOfEmployee < UseCase
    def run(inputs)
      @database = TM.database
      employee = @database.get_employee(inputs[:employee_id].to_i)
      return failure(:employee_not_found) if employee.nil?

      tasks = @database.get_employee_remaining(employee.id)
      return failure(:no_remaining_tasks_found) if tasks == []
      # Return a success with relevant data
      success :employee => employee, :tasks => tasks
    end
  end
end
