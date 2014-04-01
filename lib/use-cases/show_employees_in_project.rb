
module TM
  class ShowEmployees < UseCase
    def run(inputs)
      proj_id = inputs[:pid]
      employees = TM.DB.get_project_membership(proj_id)
      project = TM.DB.get_project(proj_id)
      return failure(:provide_a_project_id) if proj_id.nil?

      return failure(:project_doesnt_exist) if project.nil?

      success :employees => employees
    end
  end
end
