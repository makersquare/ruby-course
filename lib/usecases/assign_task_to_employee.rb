module TM
  class AssignTaskToEmployee < UseCase
    def run(inputs)
      employee = TM.db.get_employee(inputs[:employee_id])
      task = TM.db.get_task(inputs[:task_id])

      return failure(:task_does_not_exist) if task.nil?
      return failure(:employee_does_not_exist) if employee.nil?

      TM.db.assign_task_to_employee(employee.employee_id, task.task_id)

      success :task => task, :employee => employee
    end
  end
end
