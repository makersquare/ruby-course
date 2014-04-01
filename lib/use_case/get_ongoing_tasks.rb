require 'pry-debugger'
module TM
  class GetOngoingTasks < UseCase
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

      ongoing_tasks = TM::db.ongoing_tasks(data)
      return success :ongoing_tasks => ongoing_tasks
    end
  end
end
