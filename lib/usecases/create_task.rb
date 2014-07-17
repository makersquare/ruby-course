module TM
  class CreateTask < UseCase
    def run(inputs)
      project = TM.db.get_project(inputs[:project_id])

      return failure(:project_does_not_exist) if project.nil?

      task = TM.db.create_task(inputs[:description], inputs[:priority], inputs[:project_id])

      success :task => task
    end
  end
end
