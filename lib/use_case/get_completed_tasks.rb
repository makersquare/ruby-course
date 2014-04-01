module TM
  class GetCompletedTasks < UseCase
    def run(data)
      if data[:employee_id] != nil
        if TM::db.get_employee(data[:employee_id]) == nil
          return failure(:employee_not_found)
        end
      end

      if data[:project_id] != nil
        if TM::db.get_project(data[:project_id]) == nil
          return failure(:project_not_found)
        end
      end

      completed_tasks = TM::db.completed_tasks(data)
      return success :completed_tasks => completed_tasks
    end
  end
end
