module TM
  class CreateTask < UseCase
    def run(data)

      if data[:description] == nil
        return failure(:no_description_provided)
      elsif data[:priority] == nil
        return failure(:no_priority_provided)
      end

      project = TM::db.get_project(data[:project_id])
      if project == nil
        return failure(:no_project_found)
      end

      new_task = TM::db.create_task(data)
      return success :task => new_task

    end
  end
end
