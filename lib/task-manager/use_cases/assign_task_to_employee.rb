module TM
  class AssignTaskToEmployee < UseCase

    def run(inputs)

      if !validate_task(inputs)
        return failer :invalid_task
      end

      if !validate_employee(inputs)
        return failure :invalid_employee
      end

      task = db.get_task(inputs[:tid])
      emp = db.get_employee(inputs[:eid])

      # Task can only be assigned to employee if the emp does not have another task and the task is incomplete
      task.eid = emp.id

      success :task => task, :get_employee => emp
    end

    def validate_task(inputs)
      tid = inputs[:tid]
      task = db.tasks[tid]
      task && task.completed == false && task.eid == nil
    end

    def validate_employee(inputs)
      eid = inputs[:eid]
      emp = db.employees[eid]
      eid_tasks = db.tasks.values.select { |tid, task| task.eid == eid }
      eid_incomplete_tasks = tasks.select { |task| task.completed == false }
      emp && eid_tasks == [] || eid_incomplete_tasks == []
    end

    def db
      TM::DB.instance
    end
  end
end