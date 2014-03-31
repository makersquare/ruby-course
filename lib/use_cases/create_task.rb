module TM
  class CreateTask < UseCase

    def run(inputs)
      proj = TM.db.get_project(inputs[:project_id].to_i)
      return failure(:project_does_not_exist) if proj.nil?

      task = create_new_task(proj.id, inputs[:description],inputs[:priority].to_i)

      # Return a success with relevant data
      success :task => task, :project => proj
    end

    def create_new_task(proj_id, description, priority)
      TM.db.create_task(proj_id, description, priority)
    end

  end
end
