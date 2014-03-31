module TM
  class AssignTaskToEmployee < UseCase
    def run(inputs)
      tid = inputs[:tid]
      eid = inputs[:eid]

      task = TM.db.get_task(tid)
      employee = TM.db.get_employee(eid)
      return failure(:task_does_not_exist) if task.nil?
      return failure(:employee_does_not_exist) if employee.nil?

      assigned_task = TM.db.assign_task(tid, eid)

      success(assigned_task: assigned_task, employee: employee)
    end

  end
end
