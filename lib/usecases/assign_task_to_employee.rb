module TM
  class AssignTaskToEmployee < UseCase
    def run(inputs)
      employee = TM.db.get_employee(inputs[:employee_id])
      task = TM.db.get_task(inputs[:task_id])

      return failure(:task_does_not_exist) if task.nil?
      return failure(:employee_does_not_exist) if employee.nil?
      return failure(:task_already_has_employee) if task.employee_id

      TM.db.tasks[task.task_id].employee_id = employee.employee_id

      success :task => task, :employee => employee
    end
  end
end
