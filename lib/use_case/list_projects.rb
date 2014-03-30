module TM
  class ListProjects < UseCase
    def run
      projects_list = TM::db.list_projects
      if (projects_list.length == 0) then (return failure(:no_projects_found)) end

      # Return a success with relevant data
      success :projects_list => projects_list
    end
  end
end
