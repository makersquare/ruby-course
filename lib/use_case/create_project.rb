module TM
  class CreateProject < UseCase
    def run(name)
      if name.empty? then (return failure(:name_field_empty)) end

      project = TM::db.create_project(name)
      # Return a success with relevant data
      success :project => project
    end
  end
end
