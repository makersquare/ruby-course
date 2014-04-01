module TM
  class AddEmployeeToProject < UseCase

    def run(inputs)
      proj = TM.db.get_project(inputs[:project_id].to_i)
      return failure(:project_does_not_exist) if proj.nil?

      emp = TM.db.get_emp(inputs[:employee_id].to_i)
      return failure(:employee_does_not_exist) if emp.nil?

      add_employee_to_project(proj, emp)

      # Return a success with relevant data
      success :employee => emp, :project => proj
    end

    def add_employee_to_project(proj, emp)
      TM.db.update_project(proj.id, {eid: emp.id})
    end

  end
end
