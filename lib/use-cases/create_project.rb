module TM
  class CreateProjects < UseCase
    def run(inputs)
      proj_name = inputs[:project_name]
      project = TM.DB.create_project(proj_name)
      return failure(:provide_a_project_name) if proj_name == ''
      success :project => project
    end
  end
end

