module TM
  class CreateProject < UseCase
    def run(inputs)
      @database = TM.database
      projectname = (inputs[:name])
      return failure(:project_name_not_given) if projectname==''

      project = @database.create_new_project(projectname)
      # Return a success with relevant data
      success :project => project
    end
  end
end
