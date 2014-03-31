module TM
  class CreateProject < UseCase
    def run(inputs)

      project_name = inputs[:project_name]
      project = TM.db.create_project(project_name)

      return failure(:please_provide_a_project_name) if project_name == ''



      # task = DB.get_task(inputs[:task_id])

      # emp = DB.get_employee(inputs[:employee_id])
      # return failure(:employee_does_not_exist) if emp.nil?

      # add_employee_to_task(emp, task)

      # # Return a success with relevant data
      success :project => project
    end

    # def add_employee_to_task(emp, task)
    #   # NOT SHOWN: Modify task to assign to employee
    #   # ...
    # end
  end
end
