
module TM
  class ShowCompletedTasksEID < UseCase
    def run(inputs)
      eid = inputs[:eid]
      completed_tasks = TM.DB.show_completed_tasks_eid(eid)
      employee = TM.DB.get_employee(eid)
      return failure(:provide_a_emp_id) if eid.nil?

      return failure(:employee_doesnt_exist) if employee.nil?

      success :tasks => completed_tasks, :employee => employee
    end
  end
end
