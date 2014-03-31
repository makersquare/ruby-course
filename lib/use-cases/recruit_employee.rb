
module TM
  class RecruitEmployees < UseCase
    def run(inputs)
      proj_id = inputs[:pid]
      emp_id = inputs[:eid]
      project = TM.DB.get_project(proj_id)
      employee = TM.DB.get_employee(emp_id)
      return failure(:provide_a_project_id) if proj_id.nil?
      return failure(:project_doesnt_exist) if project.nil?
      return failure(:employee_doesnt_exist) if employee.nil?
      assigned = TM.DB.assign_emp_to_project(emp_id, proj_id)

      success :project => project, :employee => employee
    end
  end
end
