module TM
  class CreateProject < UseCase
    def run(name)
      # if they left the name field empty
      if name.empty?
        return failure(:name_field_empty)
      end

      project = TM::db.create_project(name)
      # Return a success with relevant data
      success :project => project
    end
  end
end
