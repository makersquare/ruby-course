module TM
  class ListProjects < UseCase
    def run(inputs)
      @database = TM.database
      projects = @database.get_all_projects
      return failure(:no_projects_found) if projects == {}

      # Return a success with relevant data
      success :projects => projects
    end
  end
end
