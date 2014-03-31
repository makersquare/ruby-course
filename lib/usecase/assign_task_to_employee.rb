module TM
  class AssignTaskToEmployee < UseCase
    def run(inputs)
      tid = inputs[:tid]
      eid = inputs[:eid]

      employee = TM.db.get_employee(eid)

      assigned_task = TM.db.assign_task(tid, eid)

      success(assigned_task: assigned_task, employee: employee)
    end

  end
end
