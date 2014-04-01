module TM
  class ShowEmployeeRemainingTasks < UseCase

    def run(inputs)
      emp = TM.db.get_emp(inputs[:employee_id].to_i)
      return failure(:employee_does_not_exist) if emp.nil?

      task_hash = show_emp_inc_tasks(emp.id)
      return failure(:employee_has_no_incomplete_tasks) if task_hash.length == 0

      # Return a success with relevant data
      success :task => task_hash, :employee => emp
    end

    def show_emp_inc_tasks(emp_id)
      TM.db.get_inc_emp_tasks(emp_id)
    end

  end
end
