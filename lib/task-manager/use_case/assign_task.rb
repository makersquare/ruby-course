

module TM
  class AssignTasktoEmployee < UseCase
    def run(inputs)
      task = TM.db.get_task(inputs[:task_id])
      return failure(:task_not_found) if task.nil?

      emp = TM.db.get_employee(inputs[:employee_id])
      return failure(:employee_not_found) if emp.nil?

      TM.db.assign_task_emp(input[:task_id],input[:employee_id])

      success(:task=>task,:employee=>emp)
    end
  end
end
