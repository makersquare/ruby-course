module TM
  class GetAllProjects < UseCase
    def run(inputs)
      projects = TM.db.get_all_projects

      return failure(:no_projects_exist) if projects == []

      success :projects => projects
    end
  end
end
