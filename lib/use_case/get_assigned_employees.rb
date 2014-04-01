module TM
  class GetAssignedEmployees < UseCase
    def run(data)
      if data[:project_id] != nil
        if TM::db.get_project(data[:project_id]) == nil
          return failure(:project_not_found)
        else
          assigned_employees = TM::db.get_assigned_employees(data)
          return success :assigned_employees => assigned_employees
        end
      elsif data[:task_id] != nil
        if TM::db.get_task(data[:task_id]) == nil
          return failure(:task_not_found)
        else
          assigned_employees = TM::db.get_assigned_employees(data)
          return success :assigned_employees => assigned_employees
        end
      end
    end
  end
end
