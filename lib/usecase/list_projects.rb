module TM
  class ListProjects < UseCase
    def run(inputs = nil)
      projects = TM.db.list_projects

      success(projects: projects)
    end
  end
end
