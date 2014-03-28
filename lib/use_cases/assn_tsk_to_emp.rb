module TM
  class AssignTaskToEmployee < UseCase

    def run(inputs)
      task = DB.get_task(inputs[:task_id])
      return failure(:task_does_not_exist) if task.nil?

      emp = DB.get_employee(inputs[:employee_id])
      return failure(:employee_does_not_exist) if emp.nil?

      add_employee_to_task(emp, task)

      # Return a success with relevant data
      success :task => task, :employee => emp
    end

    def add_employee_to_task(emp, task)
      # NOT SHOWN: Modify task to assign to employee
      # ...
    end

  end
end
