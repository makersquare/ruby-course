module TM
  class GetTasksForEmployee < UseCase
    def run(inputs)
      employee = TM.db.get_employee(inputs[:employee_id])

      return failure(:employee_does_not_exist) if employee.nil?

      tasks = TM.db.get_all_tasks

      tasks.select! { |task| task.employee_id == employee.employee_id }

      return failure(:employee_has_no_tasks) if tasks.size == 0

      success :tasks => tasks, :employee => employee
    end
  end
end
