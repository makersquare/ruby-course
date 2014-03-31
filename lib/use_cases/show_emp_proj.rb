module TM
  class ShowEmpsProjects < UseCase

    def run(inputs)
      emp = TM.db.get_emp(inputs[:employee_id].to_i)
      return failure(:employee_does_not_exist) if emp.nil?

      proj_arr = show_emps_projects(emp.id)
      return failure(:employee_is_not_assigned_to_any_projects) if proj_arr.length == 0

      # Return a success with relevant data
      success :employee => emp, :projects => proj_arr
    end

    def show_emps_projects(emp_id)
      TM.db.get_emp_proj(emp_id)
    end

  end
end
