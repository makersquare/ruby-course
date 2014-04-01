module TM
  class GetProject < UseCase
    def run(project_id)
      project = TM::db.get_project(project_id)
      if project == nil
        return failure(:project_not_found)
      end

      return success(:project => project)
    end
  end
end
