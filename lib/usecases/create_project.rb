module TM
  class CreateProject < UseCase
    def run(inputs)
      return failure(:no_name_entered) if inputs[:name].to_s == ""

      project = TM.db.create_project(inputs[:name])

      success :project => project
    end
  end
end
