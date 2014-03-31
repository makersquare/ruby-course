module TM
  class ListAllProjects < UseCase

    def run(inputs)

      projects = TM.db.get_all_proj
      return failure(:no_projects_exist) if projects.length == 0

      all_projects = list_all_proj

      # Return a success with relevant data
      success :all_projects => all_projects
    end

    def list_all_proj
      TM.db.get_all_proj
    end

  end
end
