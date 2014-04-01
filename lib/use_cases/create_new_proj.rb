module TM
  class CreateNewProj < UseCase

    def run(inputs)
      proj = create_new_project(inputs[:name])

      # Return a success with relevant data
      success :project => proj
    end

    def create_new_project (proj_name)
      TM.db.create_project(proj_name)
    end

  end
end
