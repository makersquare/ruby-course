module TM
  class EmployeeDetails < UseCase
    def run(inputs)
      eid = inputs[:eid]
      remaining_tasks = TM.DB.remaining_employee_tasks(eid)

      return failure(:provide_a_emp_id) if eid.nil?
      success :remaining_tasks => remaining_tasks

    end
  end
end

